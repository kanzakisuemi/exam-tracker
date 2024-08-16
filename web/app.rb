require 'csv'
require 'faraday'
require 'faraday/multipart'
require 'json'
require 'rack/cors'
require 'rack/session/cookie'
require 'securerandom'
require 'sinatra'
require 'will_paginate'
require 'will_paginate/array'

use Rack::Session::Cookie, 
  key: 'rack.session', 
  path: '/', 
  secret: SecureRandom.hex(64),
  same_site: :none,
  secure: true

use Rack::Cors do
  allow do
    origins 'http://api:7777'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end

enable :sessions

configure do
  set :layout, :layout
end

set :public_folder, File.expand_path('public', __dir__)

def fetch_patients
  JSON.parse(Faraday.get('http://api:7777/pacientes').body, symbolize_names: true)
end

def fetch_doctors
  JSON.parse(Faraday.get('http://api:7777/medicos').body, symbolize_names: true)
end

def fetch_exams
  JSON.parse(Faraday.get('http://api:7777/exames').body, symbolize_names: true)
end

def fetch_exam_results
  JSON.parse(Faraday.get('http://api:7777/resultados').body, symbolize_names: true)
end

def fetch_formatted_exams(page: 1, per_page: 15)
  response = Faraday.get('http://api:7777/exams')
  exams = JSON.parse(response.body, symbolize_names: true)
  paginated_exams = exams.paginate(page:, per_page:)

  {
    exams: paginated_exams,
    current_page: page,
    total_pages: paginated_exams.total_pages
  }
end

def fetch_exams_through_token(token)
  path = "http://api:7777/exams/#{token}"
  json_response = Faraday.get(path).body
  return nil if json_response.nil?

  JSON.parse(json_response, symbolize_names: true)
end

get '/' do
  page = params[:page] ? params[:page].to_i : 1
  per_page = 15
  @pagination = fetch_formatted_exams(page:, per_page:)

  erb :index
end

get '/exams' do
  @data = fetch_exams_through_token(params[:token])
  erb :exams
end

get '/import' do
  erb :import
end

post '/import' do
  if params[:csv_file]
    tempfile = params[:csv_file][:tempfile]
    filename = params[:csv_file][:filename]

    connection = Faraday.new do |conn|
      conn.request :multipart
      conn.request :url_encoded
      conn.adapter Faraday.default_adapter
    end

    response = connection.post('http://api:7777/import') do |request|
      request.headers['Content-Type'] = 'multipart/form-data'
      request.body = { csv_file: Faraday::UploadIO.new(tempfile.path, 'text/csv', filename) }
    end

    puts response.body
    puts "EU SOU UM PUUUUUTS"

    @message = JSON.parse(response.body, symbolize_names: true)[:message]
    erb :import
  end
end
