module Stylish
  class Package

    attr_reader :options, :root

    def initialize(root, options={})
      @root           = Pathname(root)
      @options        = options
    end

    def manifest
      manifest_path = case
                      when root.join("manifest.json").exist?
                        root.join("manifest.json")
                      when root.join("manifest.yml").exist?
                        root.join("manifest.yml")
                      end

      @manifest ||= Stylish::Manifest.new(manifest_path)
    end

  end
end
