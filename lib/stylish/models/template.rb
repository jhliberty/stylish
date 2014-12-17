module Stylish
  class Template
    include Stylish::Model
    include Stylish::Fs

    attribute :path, String
    attribute :type, String
    attribute :component, 'Stylish::Component'

    attribute :code, String
  end
end
