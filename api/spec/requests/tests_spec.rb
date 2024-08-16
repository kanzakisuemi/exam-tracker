require 'spec_helper'

RSpec.describe 'API Endpoints', type: :request do
  
  describe 'GET /exams/:token' do
    it 'returns formatted exams' do
      get "/exams/#{FIRST_FORMATTED_EXAM['result_token']}"
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'application/json'
      expect(last_response.body).to eq FIRST_FORMATTED_EXAM.to_json
    end
  end

  describe 'GET /' do
    it 'renders the index page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq 'text/html;charset=utf-8'
    end
  end
end
