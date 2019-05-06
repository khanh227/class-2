require 'rails_helper'
require 'csv'

describe 'Importor' do
  let(:file){ File.new('spec/fixtures/products.csv', headers: true) }
  let(:params) do
    {
      product: {
        name: 'áo thun 1',
        description: 'description 1',
        price: 34000,
        enabled: 'true',
        quatity: 3
      }
    }
  end
  before { @file_data = params[:file] }

  context 'success' do
    specify do
      expect do
      end
    end
  end
end