require 'faraday'
require 'json'
require 'sinatra'

configure do
  set :layout, :layout
end

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

get '/' do
  @patients = fetch_patients
  @doctors = fetch_doctors
  @exams = fetch_exams
  @exam_results = fetch_exam_results

  erb :index
end
