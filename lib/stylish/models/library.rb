module Stylish
  module Models
    class Library
      include Virtus.model

      attribute :name, String
      attribute :packages, Array[Stylish::Models::Package]
    end
  end
end
