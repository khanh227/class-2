require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user_admin) { create(:user, role_user: :admin) }
  let!(:user_1) { create(:user, role_user: :restaurant) }
  let!(:user_2) { create(:user, role_user: :customer) }

  before { sign_in user_admin }

  describe 'GET index' do
    before { get :index }

    specify do
      expect(assigns(:users)).to eq [user_2, user_1]
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    specify do
      get :show, params: { id: user_1.id }
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq user_1
    end
  end

  describe 'GET edit' do
    specify do
      get :edit, params: { id: user_1.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH update' do
    let(:params) do
      {
        role_user: :customer
      }
    end

    context 'success' do
      before {
        patch :update, params: { user: params, id: user_1.id }
      }

      specify do
        user_1.reload
        expect(user_1.role_user).to eq(:customer)
        expect(response).to redirect_to(users_path)
      end
    end

    context 'failure' do 
      before {
        allow_any_instance_of(User).to receive(:update).and_return(false)
      }

      specify do
        expect do
          patch :update, params: { user: params, id: user_2.id }
        end.not_to change { user_2 }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    specify do
      expect do
        delete :destroy, params: { id: user_1.id }
      end.to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
