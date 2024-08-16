require 'spec_helper'

RSpec.describe 'User accesses homepage', type: :web do
  it 'and sees exams list' do
    formatted_exams = [FIRST_FORMATTED_EXAM].map { |exam| exam.deep_symbolize_keys }
    allow_any_instance_of(Sinatra::Application).to receive(:fetch_formatted_exams).and_return(
      {
        exams: formatted_exams,
        current_page: 1,
        total_pages: 1
      }
    )

    visit '/'

    within('nav') do
      expect(page).to have_content('Rebase Labs')
    end

    expect(page).to have_content('Exames')
    expect(page).to have_content('token')
    expect(page).to have_content('IQCZ17')
    expect(page).to have_content('paciente')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('048.973.170-88')
    expect(page).not_to have_content('Anterior')
    expect(page).not_to have_content('Próximo')
  end
end
