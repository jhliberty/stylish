module Stylish
  # A `Stylish::Library` is a collection of Packages.
  #
  # Packages will be stored as folders underneath the root
  # folder which is the library.  Each package will have its
  # own manifest.
  class Library
    include Stylish::Model

    attribute :name, String
    attribute :root, Pathname
    attribute :packages, Array['Stylish::Package']

    class << self
      attr_accessor :loaded

      def current
        first = loaded.first
        return first if first

        pwd = Pathname(Dir.pwd)

        if pwd.join("library").exist?
          Stylish::Library.load_from_disk(pwd.join("library"))
          loaded.first
        end
      end
    end

    self.loaded = Set.new if self.loaded.nil?

    def packages
      super.tap do |list|
        list.map! {|p| p.library = self; p }
      end
    end

    def create_package(attributes, options={})
      library = self

      Stylish::Package.new(attributes).tap do |p|
        p.library = library
        p.initialize_folder_structure if !p.root.exist?
      end
    end

    def find_package(query)
      if query.is_a?(Hash)
        query = query[:name]
      end

      packages.detect {|package| package.name == query || package.slug == query}
    end

    def slug
      name.to_s.parameterize.downcase
    end

    # Loads a deserialized library cache, which we expect to
    # be a Hash that contains at least an array of library records.
    #
    # Example:
    #
    #   Stylish::Library.load({
    #     libraries:[{...},{...}]
    #   })
    #
    def self.load(structure)
      structure = structure.to_mash if structure.is_a?(Hash)

      # We're loading a collection of libraries
      if structure.libraries
        self.loaded += structure.libraries.map do |library|
          new(library)
        end
      # we're loading a single library
      elsif structure.packages
        self.loaded << new(structure)
      end
    end

    # Loads the stylish library metadata from a file on disk
    def self.load_from_disk(config_file_path=nil)
      path = "#{config_file_path || Stylish.config.config_file_path}".to_pathname

      raise "Invalid path" unless path.exist?

      if path.directory?
        library = path.join("library.json")

        if library.exist?
          structure = Stylish.util.deserialize(library)
        else
          structure = {root: path, packages: (path.children
            .select(&:directory?)
            .select {|p| p.join('manifest.json').exist? || p.join('manifest.yml').exist? }
            .map do |p|
              { root: p }
            end)
          }
        end
      else
        structure = Stylish.util.deserialize(path)
      end

      load(structure)
    end

    # Loads the stylish library metadata from a file in a github repository
    #
    # if the name of a repository is not passed (e.g.
    # stylish/sample-theme-one) then we will attempt to use the
    # default repository specified in the global configuration
    def self.load_from_github_repository(repository=nil)
      Stylish.ghfs.repository = repository if repository
      structure = Stylish.util.deserialize(Stylish.ghfs.open("library.json").read)

      load(structure)
    end
  end
end
