module Stylish
  class Manifest

    attr_reader :path, :options, :content

    # A stylish manifest is a JSON or YAML configuration
    # file that defines the composition of a stylish theme
    def initialize(path=nil, options={})
      @path     = path && Pathname(path)
      @options  = options

      @content          = options.fetch(:content) { self.path && self.path.read }
      @root             = options.fetch(:root) { self.path && self.path.dirname }

      @templates        = options.fetch(:templates) { manifest.templates || "templates" }
      @stylesheets      = options.fetch(:stylesheets) { manifest.stylesheets || "stylesheets" }
      @scripts          = options.fetch(:scripts) { manifest.scripts || "scripts" }
    end

    def name
      options.fetch(:name) { manifest.name }
    end

    def version
      options.fetch(:version) { manifest.version }
    end

    def categories
      Array(options.fetch(:categories) { manifest.categories })
    end

    def root
      @root && Pathname(@root)
    end

    def templates
      root.join(@templates)
    end

    def stylesheets
      root.join(@stylesheets)
    end

    def scripts
      root.join(@scripts)
    end

    def manifest
      @manifest ||= load_manifest.to_mash
    end

    def load_manifest
      if format == "json"
        JSON.parse(content) rescue {}
      elsif format == "yml"
        YAML.load(content) rescue {}
      end
    end

    def format
      options.fetch(:format) do
        path && path.extname.gsub(/^\./,'')
      end
    end

  end
end
