require 'rails_helper'

describe Products::Importor do
  let(:file){ File.new('spec/fixtures/products.csv', headers: true) }
  let!(:service) { Products::Importor.new(file_import: file).perform }
  
  context 'perform success' do
    specify do
      expect(service).to eq true
      expect(service).to change(Product, :count).by(2)
    end
  end
end
