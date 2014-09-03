require 'sprockets/developer'

module Stylish
  module Developer
    def self.config *args, &block
      Sprockets::Developer.send(:config, *args, &block)
    end

    def self.server
      Sprockets::Developer.server
    end
  end
end
