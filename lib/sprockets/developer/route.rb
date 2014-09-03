module Sprockets
  module Developer
    class Route
      def self.request(env)
        new(env)
      end

      attr_reader :request

      def initialize(env)
        @request      = Rack::Request.new(env)
      end

      def prefix
        Sprockets::Developer.config.base_url
      end

      def respond
        case
        when %w{meta content compiled}.include?(request_type)
          path_handler.to_rack_response()
        when %w{list}.include?(request_type)
          listing_handler.to_rack_response()
        end
      end

      def listing_handler
        @listing_handler ||= Sprockets::Developer::Listing.new(actual_path, request_type)
      end

      def path_handler
        @path_handler ||= Sprockets::Developer::Path.new(actual_path, request_type)
      end

      def actual_path
        request.path[/^#{ prefix }\/(\w+)\/(.+)$/, 2]
      end

      def request_type
        request.path[/^#{ prefix }\/(\w+)\/(.+)$/, 1]
      end
    end
  end
end
