module Stylish
  # The `Stylish::Component` is an HTML element that has an HTML snippet, supporting styles, scripts, etc.
  class Component
    include Stylish::Model

    attribute :name, String
    attribute :category, String

    attribute :template, 'Stylish::Template'
    attribute :script, 'Stylish::Script'
    attribute :stylesheet, 'Stylish::Stylesheet'

    # A `Stylish::Component` written in a literary format
    # will combine the contents of the fenced code blocks it contains
    # and based on the language, concatenate that into the respective
    # template, script, or stylesheet asset for the component.
    #
    # this allows for writing a component and all of its dependencies
    # in a single file, instead of jumping around. this works well with
    # the stylish front end which allows for live preview
    def self.parse_literary_format
      # TODO
      # Implement
    end
  end
end
