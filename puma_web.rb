rackup "config_web.ru"
port ENV.fetch('PORT') { 8888 }
environment ENV.fetch('RACK_ENV') { 'development' }
