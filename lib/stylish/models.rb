module Stylish
  module Model
    extend ActiveSupport::Concern

    included do
      unless defined?(Virtus)
        require 'inflecto'
        require 'virtus'
      end

      include Virtus.model(finalize: false)
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

      def set_slug_from(column=:name)
        self.slug = send(column).to_s.downcase.parameterize if self.slug.to_s.length == 0
      end

    end
  end

  module Models
    def self.load_all
      require 'stylish/models/library'
      require 'stylish/models/package'
      require 'stylish/models/theme'
      require 'stylish/models/component'
      require 'stylish/models/layout'
      require 'stylish/models/stylesheet'
      require 'stylish/models/script'
      require 'stylish/models/template'
      Virtus.finalize
    end
  end
end
