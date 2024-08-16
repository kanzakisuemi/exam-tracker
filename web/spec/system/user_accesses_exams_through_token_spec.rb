require 'spec_helper'

RSpec.describe 'User accesses exams through token', type: :web do
  it 'and sees exam details' do
    formatted_exam = {
      result_token: 'IQCZ17',
      name: 'Emilly Batista Neto',
      cpf: '048.973.170-88',
      email: 'gerald.crona@ebert-quigley.com',
      result_date: '2021-01-01',
      doctor: {
        name: 'Dr. John Doe',
        crm: '123456',
        crm_state: 'SP'
      },
      exams: [
        {
          type: 'leucócitos',
          limits: '80-120',
          result: '100'
        }
      ]
    }.deep_symbolize_keys

    allow_any_instance_of(Sinatra::Application).to receive(:fetch_exams_through_token).and_return(formatted_exam)

    visit '/'

    fill_in 'Informe o token do exame', with: 'IQCZ17'
    click_on 'Buscar'

    expect(page).to have_content('Exames para token IQCZ17')
    expect(page).to have_content('01/01/2021')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('048.973.170-88')
    expect(page).to have_content('Dr. John Doe')
    expect(page).to have_content('123456 SP')
    expect(page).to have_content('leucócitos')
    expect(page).to have_content('80-120')
    expect(page).to have_content('100')
  end
end
