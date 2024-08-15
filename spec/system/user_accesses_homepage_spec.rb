require 'spec_helper'

RSpec.describe 'User accesses homepage', type: :web do
  describe 'and sees exams list' do
    it 'and sees paginated exams list' do
      allow(Faraday).to receive(:get).with('http://api:7777/exams').and_return([FIRST_FORMATTED_EXAM].to_json)
      visit '/'
      p page.body
      within('nav') do
        expect(page).to have_content('Rebase Labs')
      end
      expect(page).to have_content('Exames')
      expect(page).to have_content('IQCZ17')
      expect(page).to have_content('Emilly Batista Neto')
      expect(page).to have_content('048.973.170-88')
    end
  end
end
