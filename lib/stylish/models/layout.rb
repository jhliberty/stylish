module Stylish
  class Layout
    include Stylish::Model
    include Stylish::Fs

    attribute :name, String
    attribute :source_language, String
    attribute :path, String
    attribute :package, 'Stylish::Package'
    attribute :components, Array['Stylish::Component']
  end
end
