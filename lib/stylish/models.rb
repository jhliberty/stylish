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

    module ClassMethods
      def browse(path, params={})
        binding.pry
      end
    end
  end

  module Models
    Types = %w(library package theme component layout stylesheet script template)

    def self.lookup(model_alias)
      a = model_alias.singularize.downcase

      if Types.include?(a)
        Stylish.const_get(a.camelize)
      end
    end

    def self.load_all
      Types.each do |type|
        require "stylish/models/#{ type }"
      end

      Virtus.finalize
    end
  end
end
