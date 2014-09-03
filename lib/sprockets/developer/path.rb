module Sprockets
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
        @sprockets ||= Sprockets::Developer.config.environment
      end

      def expanded_path
        Pathname(request_path).expand_path(Sprockets::Developer.config.root)
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
          "Content-Length" => Rack::Utils.bytesize(response_body)
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
                               meta.merge(content: asset.pathname.read,
                                          compiled: asset.to_s).to_json
                             end
                           end
      end

      def extension
        File.extname(asset.logical_path)
      end

      def content_type
        asset.content_type
      end

      def meta
        {
          logical_path: asset.logical_path,
          mtime: asset.mtime,
          digest: asset.digest,
          pathname: asset.pathname.to_s,
          size: asset.bytesize,
          dependencies: asset.dependencies
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
