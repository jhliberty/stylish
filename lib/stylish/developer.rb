require 'stylish/developer/server'
require 'stylish/developer/config'
require 'stylish/developer/reload'

module Stylish
  module Developer
    def self.server
      Stylish::Developer::Server
    end

    def self.config
      @@config ||= Stylish::Developer::Config.new
      yield(@@config) if block_given?
      @@config
    end
  end
end
