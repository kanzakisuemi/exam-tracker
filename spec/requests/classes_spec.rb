require 'spec_helper'

RSpec.describe 'API objects', type: :api do
  describe 'GET /exames' do
    it 'returns all exams' do
      get '/exames'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'application/json'
      expect(JSON.parse(last_response.body)).to include JSON.parse(Exam.all.first.to_json)
    end
  end

  describe 'GET /pacientes' do
    it 'returns all patients' do
      get '/pacientes'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'application/json'
    end
  end

  describe 'GET /medicos' do
    it 'returns all doctors' do
      get '/medicos'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'application/json'
    end
  end

  describe 'GET /resultados' do
    it 'returns all exam results' do
      get '/resultados'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'application/json'
    end
  end
end
