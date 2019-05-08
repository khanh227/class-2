require 'rails_helper'
require 'csv'

describe Products::ExportCsv do
  describe '#perform' do
    let(:service) { Products::ExportCsv.new(Product.order(created_at: :desc)) }
    let(:header) { "Name,Description,Price,Enabled,Quatity\n" }

    let(:csv_result) {
      "Name,Description,Price,Enabled,Quatity\n"+
      "product_1,about product_1,1000.0,true,8\n"+
      "product_2,about product_2,4000.0,false,12\n"
    }
    
    context 'has data' do
      let!(:product_1) { 
      create(:product,
        name: 'product_1',
        description: 'about product_1',
        price: '1000.0',
        enabled: 'true',
        quatity: '8',
        created_at: Date.new(2-1-2019))
      }

      let!(:product_2) { 
      create(:product,
        name: 'product_2',
        description: 'about product_2',
        price: '4000.0',
        enabled: 'false',
        quatity: '12',
        created_at: Date.new(1-1-2019)) 
      }

      specify do
        expect(service.perform).to eq csv_result
      end
    end

    context 'no data' do
      specify do
        expect(service.perform).to eq header
      end
    end
  end
end
