require 'spec_helper'
require 'sidekiq/testing'

RSpec.describe 'CsvJob', type: :job do
  context 'must process csv' do
    it 'and succeeds' do
      allow(Patient).to receive(:all).and_return([], [double('Patient')])
      patients = Patient.all
      expect(patients).to eq([])

      CsvJob.perform_async('support/csv_file.csv')

      result = Patient.all
      expect(result.length).to eq 1
    end
  end
end
