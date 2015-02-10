module Stylish
  module Developer

    # Handles a request to modify an asset that belongs to
    # a Stylish package.
    class Modification
      attr_reader :actual_path,
                  :request,
                  :request_type

      attr_accessor :code, :body, :headers

      def initialize(actual_path, request_type, request)
        @actual_path    = actual_path
        @request_type   = request_type
        @request        = request

        @code    = nil
        @headers = {}
        @body    = {}
      end

      def current_root
        Stylish::Developer.server.root
      end

      def file
        current_root.join(actual_path)
      end

      def file_exists?
        file && file.exist?
      end

      def file_exist?
        file_exists?
      end

      def file_writable?
        file && file.writable?
      end

      def update?
        request_type == "update"
      end

      def delete?
        request_type == "delete"
      end

      def create?
        request_type == "create"
      end

      def has_errors?
        body.key?(:errors) && !body[:errors].empty?
      end

      def add_error(message)
        self.code = 500

        binding.pry

        body[:errors] ||= []
        body[:errors] << message
      end

      def handle
        return if @handled

        if file_exists? && file_writable?
          handle_existing_file_modification
        elsif file_exist? && !file_writable?
          handle_access_denied_error
        else
          handle_non_existing_file_modification
        end

        @handled = true
      end

      def handle_access_denied_error
        add_error("Can not access file at #{ actual_path }. File not writable")
      end

      def handle_existing_file_modification
        if create?
          add_error("Can not create file at #{ actual_path }. Already exists")
        elsif update?
          file.open("w") {|fh| fh.write(contents) }
          load_path_meta
        elsif delete?
          path = file.to_s
          file.unlink if file.file?
          file.rmdir if file.directory?
          self.code = 200
          self.body = {status: "deleted", path: path}
        end
      end

      def contents
        request.params['contents']
      end

      def handle_non_existing_file_modification
        if update? || delete?
          add_error("Can not perform #{ request_type } on #{ actual_path }. File not found")
        elsif create?
          FileUtils.mkdir_p(File.dirname(file))

          file.open("w+") {|fh| fh.write(contents) }
          load_path_meta
        end
      end

      def load_path_meta
        @meta_path = Stylish::Developer::Path.new(actual_path, "meta")
      end

      def body_contents
        @body = @body.to_json if @body.is_a?(Hash)
        @body = @body.first if @body.is_a?(Array)
        @body.to_s
      end

      def to_rack_response
        handle

        return @meta_path.to_rack_response if @meta_path

        [
          code,
          headers,
          [body_contents]
        ]
      end
    end
  end
end
