module Stylish
  module Model
    extend ActiveSupport::Concern

    included do
      require 'virtus' unless defined?(Virtus)
      include Virtus.model
      include Initializers
    end

    module Initializers
      def set_default_attributes
        attribute_set.set_defaults(self)
        send(:after_initialize) if respond_to?(:after_initialize)
        self
      end

      def after_initialize
        # TODO
      end

    end
  end

  module Models
    def self.load_all
      require 'stylish/models/package'
      require 'stylish/models/library'
      require 'stylish/models/theme'
      require 'stylish/models/component'
      require 'stylish/models/layout'
      require 'stylish/models/stylesheet'
      require 'stylish/models/script'
      require 'stylish/models/template'
    end
  end
end
