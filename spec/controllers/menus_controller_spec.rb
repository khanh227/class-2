require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let!(:user_1) { create(:user) }
  let!(:menu_1) { create(:menu) }
  let!(:menu_2) { create(:menu) }
    
  describe 'GET index' do
    before { get :index }

    specify do
      expect(response).to have_http_status(302) 
      expect(response).to render_template(:index) 
      expect(assigns(:menus)).to eq [menu_2, menu_1]
    end
  end

  describe 'GET new' do
    before do
      sign_in user_1
      get :new
    end

    specify do
      expect(response).to have_http_status(200) 
      expect(response).to render_template(:new)
    end
  end 

  describe 'POST create' do
    before { sign_in user_1 }

    let(:params) do
    {
      menu: {
        menu_date: '15/05/2019',
        product_ids: [1,2],
        created_by: 1
      }
    }
    end

    context 'success' do
      specify do
        expect do
          post :create, params: params
        end.to change(Menu, :count).by(1)
        product = Menu.last
        expect(menu.menu_date).to eq '15/05/2019'
        expect(menu.product_ids).to eq [1,2]
        expect(menu.created_by).to eq 1
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
    before { sign_in user_1 }

    let(:params) do
    {
      menu: {
        menu_date: '16/05/2019',
        product_ids: [3,4],
        created_by: 2
      }
    }
    end

    context 'success' do
      specify do
        expect do
          patch :update, params: { menu: params, id: menu_1.id }
          menu_1.reload
          expect(menu_1.menu_date).to eq '16/05/2019'
          expect(menu_1.product_ids).to eq [3,4]
          expect(menu_1.created_by).to eq 2
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