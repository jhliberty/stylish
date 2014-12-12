module Stylish
  module Models
    class Package
      include Virtus.model

      attribute :name, String
      attribute :version, String
      attribute :root, Pathname
      attribute :tags, Array[String]

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
end
