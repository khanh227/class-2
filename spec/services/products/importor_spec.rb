require 'rails_helper'

describe Products::Importor do
  let(:file){ File.new('spec/fixtures/products.csv', headers: true) }
  let(:service) { Products::Importor.new(file_import: file).perform }

  describe '#perform' do
    context 'success' do
      specify do
        expect do 
          service
        end.to change(Product, :count).by(2)
        expect(Product.last.name).to eq 'iPad WiFi 128GB New 2018'
        expect(Product.last.description).to eq 'description 2'
        expect(Product.last.price).to eq 0.98e5
        expect(Product.last.enabled).to eq true
        expect(Product.last.quatity).to eq 4
      end
    end

    context 'failure' do
      # continue
    end
  end
end
