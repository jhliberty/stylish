require 'sprockets/developer/route'
require 'sprockets/developer/path'
require 'sprockets/developer/listing'

module Sprockets
  module Developer
    class Server
      def self.call(env)
        route = Route.request(env)
        response = route.respond()
        response
      end

      def self.config
        Sprockets::Developer.config
      end

      def self.sprockets
        config.environment
      end

      def self.root
        Pathname(config.root)
      end
    end
  end
end
