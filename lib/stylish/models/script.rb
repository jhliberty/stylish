module Stylish
  class Script
    include Stylish::Model

    attribute :path, String
    attribute :type, String
  end
end
