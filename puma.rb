workers 2
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup "config.ru"
port ENV.fetch('PORT') { 8888 }
environment ENV.fetch('RACK_ENV') { 'development' }
