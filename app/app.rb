require_relative 'exam'
require 'sinatra'
require 'json'

get '/tests' do
  begin
    Exam.all
  rescue PG::Error => e
    status 500
    { error: e.message }.to_json
  end
end

get '/' do
  erb :index
end
