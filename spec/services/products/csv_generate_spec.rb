require 'rails_helper'
require 'csv'

describe Products::CsvGenerate do
  describe '#perform' do
    let!(:product_1) { create(:product, name: 'product_1', description: 'about product_1', price: '1000', enabled: 'true', quatity: '8') }
    let!(:product_2) { create(:product, name: 'product_2', description: 'about product_2', price: '4000', enabled: 'false', quatity: '12') }
    let(:header) { ['Name', 'Description', 'Price', 'Enabled', 'Quatity'] }
    let(:row_1) { ['product_1', 'about product_1', '1000.0', 'true', '8'] }
    let(:row_2) { ['product_2', 'about product_2', '4000.0', 'false', '12'] }
    let(:service_1) { Products::CsvGenerate.new(Product.all) }

    context 'has data' do
      specify do
        csv_data = CSV.new(col_sep: ',', row_sep: "\n")
        csv_data << header
        csv_data << row_1
        csv_data << row_2
        expect(service_1.perform).to eq csv_data
      end
    end
  end
end
