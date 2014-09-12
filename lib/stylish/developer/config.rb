module Stylish
  module Developer
    class Config < Struct.new(:environment, :root, :base)
      def base_url
        base || "/stylish"
      end
    end
  end
end
