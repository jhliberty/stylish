module Stylish
  module Developer
    # The Route class is responsible for routing requests to the API
    # to their appropriate handler.
    class Route
      def self.request(env)
        new(env)
      end

      attr_reader :env

      def initialize(env)
        @env = env
      end

      def request
        @request      ||= Rack::Request.new(env)
      end

      def prefix
        Stylish::Developer.config.base_url
      end

      def respond
        case
        when %w{meta content compiled}.include?(request_type)
          path_handler.to_rack_response()

        when request_type == "list"
          listing_handler.to_rack_response()

        when request_type == "info"
          info_handler_rack_response

        when %w(create update delete).include?(request_type)
          modification_handler.to_rack_response()
        else
          [400, {}, ['Not found']]
        end
      end

      def info_handler_rack_response
        Stylish::Developer::Server.info_response
      end

      def modification_handler
        @modification_handler ||= Stylish::Developer::Modification.new(actual_path, request)
      end

      def listing_handler
        @listing_handler ||= Stylish::Developer::Listing.new(actual_path, request_type)
      end

      def path_handler
        @path_handler ||= Stylish::Developer::Path.new(actual_path, request_type)
      end

      def actual_path
        request.path[/^#{ prefix }\/(\w+)\/(.+)$/, 2]
      end

      def request_type
        return "info" if request.path.match(/^#{prefix}\/info$/)
        request.path[/^#{ prefix }\/(\w+)\/(.+)$/, 1]
      end
    end
  end
end
