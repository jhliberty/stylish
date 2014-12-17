module Stylish
  class Stylesheet
    include Stylish::Model

    attribute :path, String
    attribute :type, String
  end
end
