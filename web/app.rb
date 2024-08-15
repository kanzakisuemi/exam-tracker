require 'faraday'
require 'json'
require 'sinatra'
require 'will_paginate'
require 'will_paginate/array'

configure do
  set :layout, :layout
end

set :public_folder, File.expand_path('../public', __FILE__)

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

# def fetch_formatted_exams(page, per_page)
#   all_exams = JSON.parse(Faraday.get('http://api:7777/exams').body, symbolize_names: true)
#   all_exams.paginate(page: page, per_page: per_page)
# end

# get '/' do
#   @exam_results = fetch_exam_results

#   page = (params[:page] || 1).to_i
#   per_page = 15
#   @formatted_exams = fetch_formatted_exams(page, per_page)

#   erb :index
# end

def fetch_formatted_exams(page: 1, per_page: 15)
  response = Faraday.get('http://api:7777/exams')
  exams = JSON.parse(response.body, symbolize_names: true)
  paginated_exams = exams.paginate(page: page, per_page: per_page)

  {
    exams: paginated_exams,
    current_page: page,
    total_pages: paginated_exams.total_pages
  }
end

get '/' do
  page = params[:page] ? params[:page].to_i : 1
  per_page = 15
  @pagination = fetch_formatted_exams(page: page, per_page: per_page)

  erb :index
end

get '/exams' do
  path = "http://api:7777/exams/#{params[:token]}"
  json_response = Faraday.get(path).body
  @data = JSON.parse(json_response, symbolize_names: true)

  erb :exams
end
