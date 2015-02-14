module Stylish
  module Developer
    class Config < Struct.new(:environment, :root, :base, :assets_prefix, :library_root)
      def base_url
        base || "/stylish"
      end

      def asset_prefix
        assets_prefix || "/assets"
      end

      def library
        lib_root = library_root || Pathname(Dir.pwd).join("library")
        Stylish::Library.load_from_disk(lib_root)
        Stylish::Library.loaded.first
      end
    end
  end
end
