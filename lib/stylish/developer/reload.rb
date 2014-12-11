module Stylish
  module Developer
    class Reload

      def self.start options={}, &block
          reloader = new(options)
          yield(reloader) if block_given?
          reloader.start()
          Spawnling.wait(reloader.spawns)
      end

      attr_reader :spawns, :options, :logger

      def start
        @spawns = []

        @spawns << Spawnling.new { start_watcher_service() }
        @spawns << Spawnling.new { start_push_service() }
      end

      protected

      attr_accessor :options

      def initialize(options={})
        @options = options
        @logger = options[:logger]
        @logger ||= Logger.new(STDOUT)

        puts "Starting at #{ root }"
      end

      def root
        options[:root] || Stylish::Server::Developer.root || Dir.pwd()
      end

      def puts val
        @logger && @logger.info(val)
      end

      def on_file_change *args
        #modified, added, removed = args
        puts(args.inspect)
      end

      def start_watcher_service
        reload = self

        begin
          @watcher = Listen.to(root) {|*args| puts args; reload.send(:on_file_change, *args) }
          @watcher.start()
          sleep
        rescue => e
          puts e.message
        end
      end

      def start_push_service
        10.times do |n|
          puts("push #{n}")
          sleep 1
        end

      end
    end
  end
end
