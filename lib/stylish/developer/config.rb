module Stylish
  module Developer
    class Config < Struct.new(:environment, :root, :base, :assets_prefix)
      def base_url
        base || "/stylish"
      end

      def asset_prefix
        assets_prefix || "/assets"
      end
    end
  end
end
