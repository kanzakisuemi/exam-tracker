require 'spec_helper'

RSpec.describe 'User accesses exams through token', type: :web do
  it 'and sees exam details' do
    formatted_exams = [FIRST_FORMATTED_EXAM].map { |exam| exam.deep_symbolize_keys }
    allow_any_instance_of(Sinatra::Application).to receive(:fetch_formatted_exams).and_return(
      {
        exams: formatted_exams,
        current_page: 1,
        total_pages: 1
      }
    )
    allow_any_instance_of(Sinatra::Application).to receive(:fetch_exams_through_token).and_return(formatted_exams)

    visit '/'

    fill_in 'Informe o token do exame', with: 'IQCZ17'
    click_on 'Buscar'

    expect(page).to have_content('Exames para token IQCZ17')
    expect(page).to have_content('01/01/2021')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('048.973.170-88')
    expect(page).to have_content('leucócitos')
  end
end
