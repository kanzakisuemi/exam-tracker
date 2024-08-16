require 'active_support/core_ext/hash'
require 'capybara/rspec'
require 'faraday'
require 'json'
require 'rack/test'
require 'rspec'
require 'selenium-webdriver'
require_relative '../app'

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |file| require file }

def app
  Sinatra::Application
end

Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.default_driver = :rack_test
  config.javascript_driver = :selenium_chrome
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

RSpec.configure do |config|
  Capybara.app = app

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each, js: true) do
    Capybara.current_driver = Capybara.javascript_driver
  end

  config.before(:each, type: :web) do
    config.include Capybara::DSL
  end

  config.before(:each, type: :api) do
    config.include Rack::Test::Methods
  end
end
