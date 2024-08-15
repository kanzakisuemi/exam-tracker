require 'rspec'
require 'capybara/rspec'
require 'faraday'
require 'json'
require 'rack/test'
require_relative '../api/app'

Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.app_host = ENV['WEB_URL']
end

module ApiHelper
  def api_url
    ENV['API_URL']
  end

  def faraday_connection
    @faraday_connection ||= Faraday.new(url: api_url) do |conn|
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

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include ApiHelper
  config.include RSpecMixin, type: :request
  config.include RSpecMixin, type: :api

  config.before(:each, type: :api) do
    Capybara.app_host = ENV['API_URL']
  end

  config.before(:each, type: :web) do
    Capybara.app_host = ENV['WEB_URL']
  end
end
