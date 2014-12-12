module Stylish
  module Models
    class Theme
      include Virtus.model

      attribute :name, String
      attribute :version, String
    end
  end
end
