module Stylish
  module Models
    class Component
      include Virtus.model

      attribute :name, String
      attribute :category, String
    end
  end
end
