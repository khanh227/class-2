require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before { sign_in user }

  describe 'admin user' do
    let(:user) { create(:admin_user) }
    let(:user_restaurant) { create(:restaurant_user) }
    let(:user_customer) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:users)).to eq [user, user_restaurant, user_customer]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user_restaurant.id }
        expect(response).to render_template(:show)
        expect(assigns(:user)).to eq user_restaurant
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user_restaurant.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          role_user: 'customer'
        }
      end

      context 'success' do
        before {
          patch :update, params: { user: params, id: user_restaurant.id }
        }

        specify do
          user_restaurant.reload
          expect(user_restaurant.role_user).to eq 'customer'
          expect(response).to redirect_to(user_path)
        end
      end

      context 'failure' do
        before {
          allow_any_instance_of(User).to receive(:update).and_return(false)
        }

        specify do
          expect do
            patch :update, params: { user: params, id: user_customer.id }
          end.not_to change { user_customer }
          expect(response).to render_template(:edit)
        end
      end
    end
  end

  describe 'restaurant user' do
    let(:user) { create(:restaurant_user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          role_user: 'customer'
        }
      end

      context 'access denied' do
        before {
          patch :update, params: { user: params, id: user.id }
        }

        specify do
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe 'customer user' do
    let(:user) { create(:user) }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(403)
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          role_user: 'customer'
        }
      end

      context 'access denied' do
        before {
          patch :update, params: { user: params, id: user.id }
        }

        specify do
          expect(response).to have_http_status(403)
        end
      end
    end
  end
end
