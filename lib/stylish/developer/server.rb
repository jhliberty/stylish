module Stylish
  module Developer
    class Server
      def self.call(env)
        route = Route.request(env)
        status, headers, body = route.respond()

        headers["Content-Length"]                 = Rack::Utils.bytesize(body[0]).to_s
        headers["Access-Control-Allow-Origin"]    = "*"
        headers["Access-Control-Allow-Methods"]   = "GET, POST, PUT"

        [status, headers, body]
      end

      def self.config
        Stylish::Developer.config
      end

      def self.sprockets
        return config.environment if config.environment

        @sprockets_environment ||= Sprockets::Environment.new(library.root).tap do |env|
          library.packages.each do |pkg|
            pkg.root.children.select(&:directory?).each do |dir|
              env.append_path(dir)
            end
          end
        end
      end

      def self.root
        Pathname(config.root || Dir.pwd())
      end

      def self.library
        config.library
      end
    end
  end
end
