module Stylish
  module Models
    class Layout
      include Virtus.model

      attribute :name, String
      attribute :package, Stylish::Models::Package
      attribute :components, Array[Stylish::Models::Component]
    end
  end
end
