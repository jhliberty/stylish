module Stylish
  # A `Stylish::Package` is a member of the `Stylish::Library` which
  # sits on top of a collection of components, scripts, and a base
  # collection of CSS.  A `Stylish::Package` has at least one theme,
  # which is a collection of overrides and customizations to the default theme.
  class Package
    include Stylish::Model

    attribute :name, String
    attribute :version, String
    attribute :root, Pathname
    attribute :tags, Array[String]


    def after_initialize
      if !(root && root.exist?)
        raise 'Invalid package. Must include a root property which points to a path that contains the package manifest'
      end

      self.name ||= manifest.name
      self.version ||= manifest.version
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
