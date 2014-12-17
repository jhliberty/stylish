module Stylish
  class Template
    include Stylish::Model

    attribute :path, String
    attribute :type, String
  end
end
