require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:user_1) { create(:user) }
  let!(:product_1) { create(:product) }
  let!(:product_2) { create(:product) }
    
  describe 'get index' do
    before { get :index }

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:index) 
      expect(assigns(:products)).to eq [product_2, product_1]
    end
  end

  describe 'GET #new' do
    before do
      sign_in user_1
      get :new
    end

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:new)
    end
  end 

  describe 'GET #create' do
    before { sign_in user_1 }

    let(:params) do
    {
      product: {
        name: 'Product',
        description: 'Product Description',
        price: 10000,
        quatity: 1
      }
    }
    end

    context 'success' do
      specify do
        expect do
          post :create, params: params
        end.to change(Product, :count).by(1)
        product = Product.last
        expect(product.name).to eq 'Product'
        expect(product.description).to eq 'Product Description'
        expect(product.price).to eq 10000
        expect(product.quatity).to eq 1
      end
    end

    context 'failure' do
      before { 
        allow_any_instance_of(Product).to receive(:save).and_return(false) 
      }

      specify do
        expect do
          post :create, params: params
        end.not_to change { Product }
      end 
    end
  end
end
