require 'capybara/rspec'
require 'capybara/firebug'
require 'faraday'
require 'json'
require 'rack/test'
require 'rspec'
require 'selenium-webdriver'
require_relative '../api/app'

module ApiHelper  
  def faraday_connection
    @faraday_connection ||= Faraday.new(url: ENV['API_URL']) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def get_from_api(path, params = {})
    response = faraday_connection.get(path, params)
    JSON.parse(response.body) if response.success?
  rescue Faraday::Error => e
    raise "Failed to fetch data from API: #{e.message}"
  end
end

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
  config.include ApiHelper
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
    # Capybara.app_host = ENV['WEB_URL']
    Capybara.app_host = 'http://web:8888'
    Capybara.server_host = "web"
    Capybara.server_port = "8888"
  end

  config.before(:each, type: :api) do
    config.include Rack::Test::Methods
    # Capybara.app_host = ENV['API_URL']
    Capybara.app_host = 'http://api:7777'
    Capybara.server_host = 'api'
    Capybara.server_port = '7777'
  end
end
