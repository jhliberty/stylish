module Stylish
  class Theme
    include Stylish::Model

    attribute :name, String
    attribute :version, String
  end
end
