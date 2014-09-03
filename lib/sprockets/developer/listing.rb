module Sprockets
  module Developer
    class Listing
      attr_reader :request_path, :request_type

      def initialize(request_path, request_type="list")
        @request_path = request_path
        @requst_type = request_type
      end

      def response_code
        case
          when expanded_path.exist? && expanded_path.directory?
            200
          when !expanded_path.exist?
            404
          when !expanded_path.directory?
            400
          else
            500
        end
      end

      def response
        root = Sprockets::Developer.config.root
        prefix = Sprockets::Developer.config.base_url

        walk = lambda do |path_node|
          relative = path_node.relative_path_from(root)

          if path_node.file?
            {
              is_file: true,
              path: relative.to_s,
              urls: {
                content: "#{ prefix }/content/#{ relative  }",
                compiled: "#{ prefix }/compiled/#{ relative  }",
                meta: "#{ prefix }/meta/#{ relative }"
              }
            }
          else
            {
              path: relative.to_s,
              is_folder: true,
              children: path_node.children.map {|c| walk.call(c) },
              urls: {
                list: "#{ prefix }/list/#{ relative }"
              }
            }
          end
        end


        {
          path: expanded_path.relative_path_from(root).to_s,
          children: expanded_path.children.map {|n| walk.call(n) },
          is_folder: true
        }
      end

      def expanded_path
        Pathname(request_path).expand_path(Sprockets::Developer.config.root)
      end

      def response_headers
        {
          "Content-Length" => content_length
        }
      end

      def response_body
        response.to_json
      end

      def content_length
        Rack::Utils.bytesize(response_body)
      end

      def to_rack_response
        [response_code, response_headers, [response_body]]
      end
    end
  end
end
