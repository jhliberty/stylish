require "stylish/version"
require "stylish/developer"

module Stylish
  require 'stylish/engine' if defined?(::Rails)
end
