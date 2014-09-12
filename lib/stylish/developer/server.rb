require 'Stylish/developer/route'
require 'Stylish/developer/path'
require 'Stylish/developer/listing'

module Stylish
  module Developer
    class Server
      def self.call(env)
        route = Route.request(env)
        response = route.respond()
        response
      end

      def self.config
        Stylish::Developer.config
      end

      def self.Stylish
        config.environment
      end

      def self.root
        Pathname(config.root)
      end

      def self.info_response
        body = {
          root: root,
          paths: Stylish.paths
        }.to_json

        headers = {
          "Content-Length" => Rack::Utils.bytesize(body)
        }

        [200, headers, [body]]
      end
    end
  end
end
