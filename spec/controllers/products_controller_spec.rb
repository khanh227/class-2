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
end
