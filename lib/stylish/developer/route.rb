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
        data = case
        when %w{meta content compiled}.include?(request_type)
          path_handler.to_rack_response()

        when request_type == "list"
          listing_handler.to_rack_response()
        when request_type == "models"
          models_handler.to_rack_response()
        when request_type == "info"
          info_handler_rack_response
        when %w(create update delete).include?(request_type)
          modification_handler.to_rack_response()
        else
          [404, {}, ['Not found']]
        end

        status, headers, body = data

        [status, headers, body]
      end

      def info_handler_rack_response
        body = {
          root: Stylish::Developer.server.root.to_s,
          sprockets_paths: Stylish::Developer.server.sprockets.paths,
          library: Stylish::Developer.config.library.as_json
        }.to_json

        headers = {
          "Content-Type" => "application/json"
        }

        [200, headers, [body]]
      end

      def models_handler
        parts   = actual_path.split("/")
        action  = parts.shift
        prefix  = parts.shift
        path    = parts.join("/")

        @models_handler ||= Stylish::Developer::ModelDelegator.new(path, action, prefix, request)
      end

      def modification_handler
        @modification_handler ||= Stylish::Developer::Modification.new(actual_path, request_type, request)
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
