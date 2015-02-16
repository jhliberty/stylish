
module Stylish
  # A `Stylish::Package` is a member of the `Stylish::Library` which
  # sits on top of a collection of components, scripts, and a base
  # collection of CSS.  A `Stylish::Package` has at least one theme,
  # which is a collection of overrides and customizations to the default theme.
  class Package
    include Stylish::Model

    attribute :name, String
    attribute :version, String
    attribute :slug, String
    attribute :root, Pathname
    attribute :tags, Array[String]

    attribute :library, 'Stylish::Library'

    def after_initialize
      set_slug_from(:name)

      if !self.root
        self.root = library_root.try(:join, slug)
      end

      if folder_exists?
        self.name ||= manifest.name
        self.version ||= manifest.version
      end

      set_slug_from(:name)
    end

    def to_hash(full=false)
      super().tap {|h| h.delete(:library) }.tap do |h|
        h[:manifest] = manifest if full
        h[:root] = h[:root].to_s
      end
    end

    def library
      super || Stylish::Library.loaded.to_a.last
    end

    def initialize_folder_structure
      raise 'Can not determine package root' unless root

      FileUtils.mkdir_p root
      FileUtils.mkdir_p root.join('templates')
      FileUtils.mkdir_p root.join('scripts')
      FileUtils.mkdir_p root.join('stylesheets')

      unless root.join("manifest.json").exist?
        root.join("manifest.json").open("w+") do |fh|
          fh.write({name: name,
                   version: version || "0.0.1",
                   categories: %w(Headers, Footers)}.to_json)
        end
      end
    end

    def library_root
      library.try(:root)
    end

    def folder_exists?
      root && root.exist?
    end

    def manifest
      manifest_path = case
                      when root.join("manifest.json").exist?
                        root.join("manifest.json")
                      when root.join("manifest.yml").exist?
                        root.join("manifest.yml")
                      end

      @manifest ||= Stylish::Manifest.new(manifest_path) if manifest_path
    end
  end
end
