require "hashie"
require "singleton"
require "set"
require "active_support/core_ext"
require "stylish/core_ext"
require "github-fs"
require 'rack'

require "stylish/version"
require "stylish/configuration"

require "stylish/developer"
require 'stylish/developer/server'
require 'stylish/developer/route'
require 'stylish/developer/path'
require 'stylish/developer/listing'
require 'stylish/developer/modification'
require 'stylish/developer/model_delegator'

require 'stylish/developer/config'
require 'stylish/developer/environment'

require "stylish/manifest"
require "stylish/fs"
require "stylish/models"
require "stylish/util"

module Stylish
  require 'stylish/engine' if defined?(::Rails)

  def self.util
    Stylish::Util
  end

  def self.config
    Stylish::Configuration.instance
  end
end

Stylish::Models.load_all()
