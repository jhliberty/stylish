module Stylish
  module Models
    class Library
      include Virtus.model

      attribute :name, String
      attribute :packages, Array[Stylish::Models::Package]

      class << self
        attr_accessor :loaded
      end

      self.loaded = Set.new if self.loaded.nil?

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

        self.loaded += structure.libraries.map do |library|
          new(library)
        end
      end

      # Loads the stylish library metadata from a file on disk
      def self.load_from_disk(config_file_path=nil)
        path = "#{config_file_path || Stylish.config.config_file_path}".to_pathname
        structure = Stylish.util.deserialize(path)

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
end
