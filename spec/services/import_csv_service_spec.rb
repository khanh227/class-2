require 'rails_helper'
require 'csv'

describe 'ImportCsv' do
  let(:file){ File.new('spec/fixtures/products.csv', headers: true) }

  specify do
    expect do
      expect(assigns(file.success)).to eq false
      expect(assigns(file.messages)).to eq 0
      expect(assigns(file.csv_valid?)).to eq 'message true'
      expect(assigns(File.extname(file.original_filename) == '.csv')).to eq '.csv'
    end
  end
end
