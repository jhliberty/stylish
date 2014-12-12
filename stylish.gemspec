# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stylish/version'

Gem::Specification.new do |spec|
  spec.name          = "stylish"
  spec.version       = Stylish::VERSION
  spec.authors       = ["Jonathan Soeder"]
  spec.email         = ["jonathan.soeder@gmail.com"]
  spec.description   = %q{Stylish is a theming toolkit based on semantic-ui}
  spec.summary       = %q{Stylish is a theming toolkit for building bootstrap and semantic-ui themes}
  spec.homepage      = "http://stylish.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
    
  spec.add_dependency 'hashie'
  spec.add_dependency 'sprockets', '>= 2.0.0'
  spec.add_dependency 'commander'
  spec.add_dependency 'github-fs'
  spec.add_dependency 'virtus', '>= 1.0.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency 'rails', '~> 4.1.1'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'sass-rails', '>= 4.0.1'
  spec.add_development_dependency 'coffee-rails', '>= 4.0.0'
end
