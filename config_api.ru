require_relative './api/app'
unless ENV['RACK_ENV'] == 'test'
  run Sinatra::Application
end
