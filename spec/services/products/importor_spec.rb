require 'rails_helper'

describe Products::Importor do
  let(:service) { Products::Importor.new(file_import: file) }

  describe '#perform' do
    context 'success' do
      let(:file) { fixture_file_upload('spec/fixtures/products.csv') }
      specify do
        expect do 
          service.perform
        end.to change(Product, :count).by(2)
        expect(service.perform).to eq true
        expect(service.messages).to eq 'message true'
        expect(Product.last.name).to eq 'iPad WiFi 128GB New 2018'
        expect(Product.last.description).to eq 'description 2'
        expect(Product.last.price).to eq 0.98e5
        expect(Product.last.enabled).to eq true
        expect(Product.last.quatity).to eq 4
      end
    end

    context 'failure' do
      let(:file) { fixture_file_upload('spec/fixtures/products.txt') }
      before { allow_any_instance_of(Product).to receive(:save).and_return(false) }

      specify do
        expect(service.success?).to eq false
      end

      context 'file is not csv' do
        specify do
          expect(service.csv_valid?).to eq false
        end
      end
    end
  end
end
