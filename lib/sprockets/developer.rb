require 'sprockets/developer/server'
require 'sprockets/developer/config'

module Sprockets
  module Developer
    def self.server
      Sprockets::Developer::Server
    end

    def self.config
      @@config ||= Sprockets::Developer::Config.new
      yield(@@config) if block_given?
      @@config
    end
  end
end
