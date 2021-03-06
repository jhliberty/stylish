ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'rack/test'
require 'pry'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

module Stylish
  def self.fixtures_path
    Pathname(File.dirname(__FILE__)).join("fixtures")
  end

  def self.test_javascript_path
    Pathname(File.dirname(__FILE__)).join("dummy","app","assets","javascripts")
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include Rack::Test
  config.include Requests::JsonHelpers, type: :request
end
