module Stylish
  class Configuration
    include Singleton

    def self.method_missing(meth, *args, &block)
      if instance.respond_to?(meth)
        instance.send(meth, *args, &block)
      else
        super
      end
    end

    def method_missing(meth, *args, &block)
      if config.respond_to?(meth)
        config.send(meth, *args, &block)
      else
        super
      end
    end

    def config
      @config ||= Hashie::Mash.new
    end

    def load_from_file(path)
      path = path.to_s.to_pathname

      payload = if path.extname == ".yml"
        YAML.load path.read
      elsif path.extname == ".json"
        JSON.parse path.read
      end

      config.merge!(payload)
    end

  end
end
