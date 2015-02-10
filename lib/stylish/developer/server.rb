require 'stylish/developer/route'
require 'stylish/developer/path'
require 'stylish/developer/listing'
require 'stylish/developer/modification'

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

      def self.sprockets
        config.environment
      end

      def self.root
        Pathname(config.root || Dir.pwd())
      end
    end
  end
end
