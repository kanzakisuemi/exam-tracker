rackup "config_api.ru"
port ENV.fetch('PORT') { 7777 }
environment ENV.fetch('RACK_ENV') { 'development' }
