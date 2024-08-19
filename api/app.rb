require_relative 'models/exam'
require_relative 'models/exam_result'
require_relative 'models/doctor'
require_relative 'models/patient'
require_relative '../db/initialize_db'
require '/app/sidekiq/job'
require 'csv'
require 'json'
require 'rack/cors'
require 'rack/session/cookie'
require 'securerandom'
require 'sidekiq'
require 'sinatra'
require 'sinatra/json'

use Rack::Session::Cookie, 
  key: 'rack.session', 
  path: '/', 
  secret: SecureRandom.hex(64),
  same_site: :none,
  secure: true

use Rack::Cors do
  allow do
    origins 'http://web:8888'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end

configure do
  set :layout, :layout
end

def handle_request
  yield
rescue PG::Error => e
  status 500
  { error: e.message }.to_json
end

get '/exams/:token' do
  content_type :json
  json ResultFormatter.fetch_formatted_exams_by_token(params[:token])
end

get '/patient/:cpf' do
  content_type :json
  json ResultFormatter.fetch_formatted_exams_by_cpf(params[:cpf])
end

get '/exams' do
  content_type :json
  json ResultFormatter.fetch_formatted_exams
end

post '/import' do
  content_type :json

  if params[:csv_file]
    tempfile = params[:csv_file][:tempfile]
    csv_content = tempfile.read
    
    CsvJob.perform_async(csv_content)

    { message: 'Arquivo recebido e processamento iniciado!' }.to_json
  else
    { message: 'Nenhum arquivo enviado!' }.to_json
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
end
