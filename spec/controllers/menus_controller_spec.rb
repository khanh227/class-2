require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let(:product_1) { create(:product, name: 'Product 1') }
  let(:product_2) { create(:product, name: 'Product 2') }
  let(:product_3) { create(:product, name: 'Product 3') }

  let!(:menu_1) { create(:menu, product_ids: [product_1.id, product_2.id]) }
  let!(:menu_2) { create(:menu, product_ids: [product_3.id]) }

  before { sign_in user }
    
  describe 'GET index' do
    before { get :index }

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:index) 
      expect(assigns(:menus)).to eq [menu_1, menu_2]
    end
  end

  describe 'GET new' do
    before { get :new }

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:new)
    end
  end 

  describe 'POST create' do

    let(:params) do
    {
      menu_1: {
        menu_date: '2019-05-15',
        product_ids: [2,3],
        created_by: user.id
      }
    }
    end

    context 'success' do
      specify do
        expect do
          post :create, params: params
        end.to change(Menu, :count).by(1)
        product = Menu.last
        expect(menu_1.menu_date).to eq '2019-05-15'
        expect(menu_1.products.first).to eq [3]
        expect(menu_1.created_by).to eq user.id
      end
    end

    context 'failure' do
      before { 
        allow_any_instance_of(Menu).to receive(:save).and_return(false) 
      }

      specify do
        expect do
          post :create, params: params
        end.not_to change { Menu }
      end 
    end
  end

  describe 'PATCH update' do

    let(:params) do
    {
      menu: {
        product_ids: [3],
      }
    }
    end

    context 'success' do
      specify do
        expect do
          patch :update, params: { menu: params, id: menu_1.id }
          menu_1.reload
          expect(menu_1.products).to eq [3]
        end
      end
    end

    context 'failure' do
      before { allow_any_instance_of(Menu).to receive(:update).and_return(false) }
      
      specify do
        expect do
          patch :update, params: {menu: params, id: menu_1.id}
        end.not_to change { menu_1 }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    specify do
      expect do
        delete :destroy, params: {id: menu_2.id}
      end.to change(Menu, :count).by(-1)
      expect(response).to redirect_to menus_path
    end
  end
end