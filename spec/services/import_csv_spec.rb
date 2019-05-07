require 'rails_helper'

describe ImportCsv do
  let(:file){ File.new('spec/fixtures/products.csv', headers: true) }
  let!(:service) { Products::Importor.new(file_import: file) }

  specify do
    expect(service.success).to eq false
    expect(service.messages).not_to eq ''
    expect(service.csv_valid?).to eq true
  end
end

