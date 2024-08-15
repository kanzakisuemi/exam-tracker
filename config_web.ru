require_relative './web/app'
unless ENV['RACK_ENV'] == 'test'
  run Sinatra::Application
end

