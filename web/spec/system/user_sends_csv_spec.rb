require 'spec_helper'

RSpec.describe 'User sends CSV', type: :system do
  it 'sends a CSV file to the API' do
    visit '/'
    click_on 'Enviar CSV'

    within('form#csv') do
      attach_file('csv_file', File.expand_path('/app/web/spec/support/csv_file.csv'))
      click_on 'Enviar'
    end

    expect(page).to have_content('Arquivo recebido e processamento iniciado!')
  end
end
