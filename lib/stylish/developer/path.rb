module Stylish
  module Developer
    class Path
      attr_reader :request_path, :request_type

      def initialize(request_path, request_type="content")
        @request_path = request_path.to_s
        @request_type = request_type
      end

      def asset
        @asset ||= begin
                     parts = request_path.split('/')

                     found = !!(sprockets.find_asset(request_path))

                     until found || parts.empty?
                       test = parts.join('/')
                       found = !!!(sprockets.find_asset(test).nil?)
                       parts.shift unless found
                     end

                      sprockets.find_asset Array(parts).join('/')
                   end
      end

      def exists_under_root?
        expanded_path.exist?
      end

      def sprockets
        self.class.sprockets
      end

      def self.sprockets
        @sprockets ||= Stylish::Developer.config.environment
      end

      def expanded_path
        Pathname(request_path).expand_path(Stylish::Developer.config.root)
      end

      def asset_exists?
        expanded_path.exist?
      end

      def sprockets_asset
        sprockets.find_asset(asset)
      end

      def meta?
        request_type == "meta"
      end

      def content?
        request_type == "content"
      end

      def compiled?
        request_type == "compiled"
      end

      def response_headers
        {
          "Content-Length"  => "#{Rack::Utils.bytesize(response_body)}",
          "Content-Type"    => content_type
        }
      end

      def response_body
        @response_body ||= begin
                             case
                             when not_found?
                               {
                                 status: 404,
                                 message: "Not Found"
                               }.to_json
                             when content?
                               asset.pathname.read
                             when compiled?
                               asset.to_s
                             when meta?
                               meta.to_json
                             end
                           end
      end

      def raw_asset_content
        begin
          asset.pathname.read
        rescue => exception
          "Error reading asset content:\n\n#{exception.message}"
        end
      end

      def compiled_asset_content
        begin
          asset.to_s
        rescue => exception
          "Error compiling asset content:\n\n#{ exception.message }"
        end
      end

      def extension
        File.extname(asset.logical_path)
      end

      def content_type
        asset.content_type
      end

      def relative_pathname
        Pathname(asset.pathname.relative_path_from(Stylish::Developer.config.root))
      end

      def prefix
        Stylish::Developer.config.base_url
      end

      def meta
        {
          logical_path: asset.logical_path,
          mtime: asset.mtime.to_i.to_s,
          digest: asset.digest,
          pathname: relative_pathname.to_s,
          size: asset.bytesize.to_s,
          urls: {
            meta_url: "#{ prefix }/meta/#{relative_pathname}",
            compiled_url: "#{ prefix }/compiled/#{relative_pathname}",
            content_url: "#{ prefix }/content/#{relative_pathname}"
          },
          dependencies: asset.dependencies.map do |dependency|
            dependency.logical_path
          end
        }
      end

      def status_code
        @status_code ||= begin
                           case
                           when exists_under_root?
                             200
                           when !exists_under_root?
                             404
                           else
                             500
                           end
                         end
      end

      def to_rack_response
        [status_code, response_headers, [response_body]]
      end

      def not_found?
        status_code == 404
      end

      def error?
        status_code == 500
      end

      def success?
        status_code == 200 || status_code == 304
      end
    end
  end
end
