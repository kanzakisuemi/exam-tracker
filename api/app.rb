require_relative 'models/exam'
require_relative 'models/exam_result'
require_relative 'models/doctor'
require_relative 'models/patient'
require_relative '../db/initialize_db'
require 'sinatra'
require 'sinatra/json'
require 'json'

configure do
  set :layout, :layout
end

def handle_request
  yield
rescue PG::Error => e
  status 500
  { error: e.message }.to_json
end

get '/exams' do
  handle_request do
    json data = Database.fetch_formatted_exams
  end
end

get '/exams/raw' do
  handle_request do
    json data = Database.fetch_raw_exams
  end
end

get '/exames' do
  handle_request do
    json Exam.all
  end
end

get '/pacientes' do
  handle_request do
    json Patient.all
  end
end

get '/medicos' do
  handle_request do
    json Doctor.all
  end
end

get '/resultados' do
  handle_request do
    json ExamResult.all
  end
end

get '/' do
  erb :index
end
