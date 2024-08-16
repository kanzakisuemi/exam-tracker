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
    expect(page).to have_content('paciente')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('cpf')
    expect(page).to have_content('048.973.170-88')
    expect(page).to have_content('email')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('token')
    expect(page).to have_content('IQCZ17')
    expect(page).to have_content('emissão do resultado')
    expect(page).to have_content(Date.parse('2021-08-05').strftime('%d/%m/%Y'))
    expect(page).to have_link('ver meus exames', href: '/exams?token=IQCZ17')

    expect(page).not_to have_content('Anterior')
    expect(page).not_to have_content('Próximo')
  end
  it 'and sees exams details' do
    formatted_exams = [FIRST_FORMATTED_EXAM].map { |exam| exam.deep_symbolize_keys }
    allow_any_instance_of(Sinatra::Application).to receive(:fetch_formatted_exams).and_return(
      {
        exams: formatted_exams,
        current_page: 1,
        total_pages: 1
      }
    )
    allow_any_instance_of(Sinatra::Application).to receive(:fetch_exams_through_token).and_return(formatted_exams.first)

    visit '/'

    expect(page).to have_content('Exames')
    expect(page).to have_content('token')
    expect(page).to have_content('IQCZ17')
    expect(page).to have_content('paciente')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('048.973.170-88')
    click_on 'ver meus exames'

    expect(page).to have_content('Exames para token IQCZ17')
    expect(page).to have_content('05/08/2021')
    expect(page).to have_content('Emilly Batista Neto')
    expect(page).to have_content('gerald.crona@ebert-quigley.com')
    expect(page).to have_content('048.973.170-88')
    expect(page).to have_content('Maria Luiza Pires')
    expect(page).to have_content('B000BJ20J4 PI')
    expect(page).to have_content('hemácias')
    expect(page).to have_content('45-52')
    expect(page).to have_content('97')
    expect(page).to have_content('leucócitos')
    expect(page).to have_content('9-61')
    expect(page).to have_content('89')
    expect(page).to have_content('plaquetas')
    expect(page).to have_content('11-93')
    expect(page).to have_content('97')
    expect(page).to have_content('hdl')
    expect(page).to have_content('19-75')
    expect(page).to have_content('0')
    expect(page).to have_content('ldl')
    expect(page).to have_content('45-54')
    expect(page).to have_content('80')
    expect(page).to have_content('vldl')
    expect(page).to have_content('48-72')
    expect(page).to have_content('82')
    expect(page).to have_content('glicemia')
    expect(page).to have_content('25-83')
    expect(page).to have_content('98')
    expect(page).to have_content('tgo')
    expect(page).to have_content('50-84')
    expect(page).to have_content('87')
    expect(page).to have_content('tgp')
    expect(page).to have_content('38-63')
    expect(page).to have_content('9')
    expect(page).to have_content('eletrólitos')
    expect(page).to have_content('2-68')
    expect(page).to have_content('85')
    expect(page).to have_content('tsh')
    expect(page).to have_content('25-80')
    expect(page).to have_content('65')
    expect(page).to have_content('t4-livre')
    expect(page).to have_content('34-60')
    expect(page).to have_content('94')
    expect(page).to have_content('ácido úrico')
    expect(page).to have_content('15-61')
    expect(page).to have_content('2')
  end
end
