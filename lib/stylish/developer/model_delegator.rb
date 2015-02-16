module Stylish
  module Developer
    class ModelDelegator
      attr_reader :path, :action, :request, :library, :prefix, :parts

      attr_accessor :code

      def initialize(path, action, prefix, request, library=nil)
        @path       = path
        @action     = action
        @request    = request
        @prefix     = prefix
        @library    = library || Stylish::Developer.config.library
        @code       = 200
        @parts      = path.split("/")
      end

      def response_body
        case
        when prefix == "packages" && action == "browse"
          library.packages.map(&:to_hash)
        when prefix == "packages" && action == "show"
          slug = parts.first
          package = library.find_package(slug)
          package.to_hash(true)
        else
          self.code = 400

          {
            error: "invalid request",
            path: path,
            action: action,
            prefix: prefix,
            request: request.path
          }
        end
      end

      def to_rack_response
        [code, {"Content-Type"=>"application/json"}, [response_body.to_json] ]
      end
    end
  end
end
