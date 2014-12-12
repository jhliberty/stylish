require "virtus"
require "hashie"
require "singleton"
require "set"
require "active_support/core_ext"
require "stylish/core_ext"

require "stylish/version"
require "stylish/configuration"
require "stylish/developer"
require "stylish/manifest"
require "stylish/models/package"
require "stylish/models/library"

module Stylish
  require 'stylish/engine' if defined?(::Rails)

  def self.config
    Stylish::Configuration.instance
  end
end
