require 'spec_helper'

RSpec.describe 'API Endpoints', type: :request do
  
  describe 'GET /exams' do
    it 'returns formatted exams' do
      allow(Database).to receive(:fetch_formatted_exams).and_return([
        {
          "result_token" => "P5T1PT",
          "result_date" => "2021-08-10",
          "cpf" => "083.892.729-70",
          "name" => "João Samuel Garcês",
          "email" => "madonna@gerhold-bode.io",
          "birthday" => "1967-07-06",
          "doctor" => { 
            "crm" => "B000BJ8TIA",
            "crm_state" => "PR",
            "name" => "Ana Sophia Aparício Neto"
          },
          "exams" => [
            {
              "type" => "hemácias",
              "limits" => "45-52",
              "result" => "3"
            },
            {
              "type" => "leucócitos",
              "limits" => "9-61",
              "result" => "10"
            },
            {
              "type" => "plaquetas",
              "limits" => "11-93",
              "result" => "29"
            },
            {
              "type" => "hdl",
              "limits" => "19-75",
              "result" => "92"
            }
          ]
        },
        {
          "result_token" => "IQCZ17",
          "result_date" => "2021-08-05",
          "cpf" => "048.973.170-88",
          "name" => "Emilly Batista Neto",
          "email" => "gerald.crona@ebert-quigley.com",
          "birthday" => "2001-03-11",
          "doctor" => {
            "crm" => "B000BJ20J4",
            "crm_state" => "PI",
            "name" => "Maria Luiza Pires"
          }, 
          "exams" => [
            {
              "type" => "hemácias",
              "limits" => "45-52",
              "result" => "97"
            },
            {
              "type" => "leucócitos",
              "limits" => "9-61",
              "result" => "89"
            },
            {
              "type" => "plaquetas",
              "limits" => "11-93",
              "result" => "97"
            }
          ]
        }
      ])
      get '/exams'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
      expect(JSON.parse(last_response.body)).to eq([
        {
          "result_token" => "P5T1PT",
          "result_date" => "2021-08-10",
          "cpf" => "083.892.729-70",
          "name" => "João Samuel Garcês",
          "email" => "madonna@gerhold-bode.io",
          "birthday" => "1967-07-06",
          "doctor" => { 
            "crm" => "B000BJ8TIA",
            "crm_state" => "PR",
            "name" => "Ana Sophia Aparício Neto"
          },
          "exams" => [
            {
              "type" => "hemácias",
              "limits" => "45-52",
              "result" => "3"
            },
            {
              "type" => "leucócitos",
              "limits" => "9-61",
              "result" => "10"
            },
            {
              "type" => "plaquetas",
              "limits" => "11-93",
              "result" => "29"
            },
            {
              "type" => "hdl",
              "limits" => "19-75",
              "result" => "92"
            }
          ]
        },
        {
          "result_token" => "IQCZ17",
          "result_date" => "2021-08-05",
          "cpf" => "048.973.170-88",
          "name" => "Emilly Batista Neto",
          "email" => "gerald.crona@ebert-quigley.com",
          "birthday" => "2001-03-11",
          "doctor" => {
            "crm" => "B000BJ20J4",
            "crm_state" => "PI",
            "name" => "Maria Luiza Pires"
          }, 
          "exams" => [
            {
              "type" => "hemácias",
              "limits" => "45-52",
              "result" => "97"
            },
            {
              "type" => "leucócitos",
              "limits" => "9-61",
              "result" => "89"
            },
            {
              "type" => "plaquetas",
              "limits" => "11-93",
              "result" => "97"
            }
          ]
        }
      ])
    end
  end

  describe 'GET /exams/raw' do
    it 'returns raw exams' do
      get '/exams/raw'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
    end
  end

  describe 'GET /exames' do
    it 'returns all exams' do
      get '/exames'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
    end
  end

  describe 'GET /pacientes' do
    it 'returns all patients' do
      get '/pacientes'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
    end
  end

  describe 'GET /medicos' do
    it 'returns all doctors' do
      get '/medicos'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
    end
  end

  describe 'GET /resultados' do
    it 'returns all exam results' do
      get '/resultados'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('application/json')
      # Adicione mais expectativas conforme necessário
    end
  end

  describe 'GET /' do
    it 'renders the index page' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq('text/html;charset=utf-8')
    end
  end
end
