module Stylish
  class Layout
    include Stylish::Model

    attribute :name, String
    attribute :package, Stylish::Package
    attribute :components, Array[Stylish::Component]
  end
end
