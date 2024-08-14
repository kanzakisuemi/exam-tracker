require_relative 'exam'
require_relative 'exam_result'
require_relative 'doctor'
require_relative 'patient'
require_relative '../db/initialize_db'
require 'sinatra'
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

get '/tests' do
  handle_request do
    results = Database.fetch_all_exam_data
    results.map { |row| row }.to_json
  end
end

get '/exames' do
  handle_request do
    Exam.all.to_json
  end
end

get '/pacientes' do
  handle_request do
    Patient.all.to_json
  end
end

get '/medicos' do
  handle_request do
    Doctor.all.to_json
  end
end

get '/resultados' do
  handle_request do
    ExamResult.all.to_json
  end
end

get '/' do
  erb :index
end
