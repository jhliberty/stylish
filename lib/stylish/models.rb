module Stylish
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
