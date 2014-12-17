module Stylish
  class Component
    include Stylish::Model

    attribute :name, String
    attribute :category, String
  end
end
