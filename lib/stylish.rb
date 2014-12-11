require "stylish/version"
require "stylish/developer"
require "stylish/manifest"
require "stylish/package"
require "hashie"

module Stylish
  require 'stylish/engine' if defined?(::Rails)
end

class Hash
  def to_mash
    Hashie::Mash.new(self)
  end
end
