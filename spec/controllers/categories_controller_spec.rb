require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:user_1) { create(:admin_user) }
  let!(:user_2) { create(:restaurant_user) }
  let!(:user_3) { create(:user) }
  let!(:category_1) { create(:category) }
  let!(:category_2) { create(:category) }

  context 'Admin User' do
    before { sign_in user_1 }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:categories)).to eq [category_1, category_2]
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: category_1.id }
        expect(response).to render_template(:show)
        expect(assigns(:category)).to eq category_1
      end
    end

    describe 'GET new' do
      specify do
        get :new
        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: category_1.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST create' do
      let(:params) do
        {
          name: 'category 3',
          enabled: false
        }
      end

      context 'success' do
        specify do
          expect do
            post :create, params: { category: params }
          end.to change(Category, :count).by(1)
          category = Category.last
          expect(category.name).to eq 'category 3'
          expect(category.enabled).to eq false
          expect(response).to redirect_to categories_path
        end
      end

      context 'failure' do
        before {
          allow_any_instance_of(Category).to receive(:save).and_return(false)
        }

        specify do
          expect do
            post :create, params: { category: params }
          end.not_to change(Category, :count)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          name: 'category 4',
          enabled: true
        }
      end

      context 'success' do
        before {
          patch :update, params: { category: params, id: category_1.id }
        }

        specify do
          category_1.reload
          expect(category_1.name).to eq 'category 4' 
          expect(category_1.enabled).to eq true 
          expect(response).to redirect_to categories_path
        end
      end

      context 'failure' do
        before {
          allow_any_instance_of(Category).to receive(:update).and_return(false)
        }

        specify do
          expect do
            patch :update, params: { category: params, id: category_1.id }
          end.not_to change { category_1 }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: { id: category_1.id }
        end.to change(Category, :count).by(-1)
        expect(response).to redirect_to categories_path
      end
    end
  end

  context 'Restaurant User' do
    before { sign_in user_2 }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:categories)).to eq [category_1, category_2]
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: category_1.id }
        expect(response).to render_template(:show)
        expect(assigns(:category)).to eq category_1
      end
    end

    describe 'GET new' do
      specify do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: category_1.id }
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST create' do
      let(:params) do
        {
          name: 'category 5',
          enabled: true
        }
      end

      context 'success' do
        specify do
          expect do
            post :create, params: { category: params }
          end.to change(Category, :count).by(1)
          category = Category.last
          expect(category.name).to eq 'category 5'
          expect(category.enabled).to eq true
          expect(response).to redirect_to categories_path
        end
      end

      context 'failure' do
        before {
          allow_any_instance_of(Category).to receive(:save).and_return(false)
        }

        specify do
          expect do
            post :create, params: { category: params }
          end.not_to change(Category, :count)
          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          name: 'category 6',
          enabled: false
        }
      end

      context 'success' do
        before {
          patch :update, params: { category: params, id: category_1.id }
        }

        specify do
          category_1.reload
          expect(category_1.name).to eq 'category 6' 
          expect(category_1.enabled).to eq false 
          expect(response).to redirect_to categories_path
        end
      end

      context 'failure' do
        before {
          allow_any_instance_of(Category).to receive(:update).and_return(false)
        }

        specify do
          expect do
            patch :update, params: { category: params, id: category_1.id }
          end.not_to change { category_1 }
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: { id: category_1.id }
        end.to change(Category, :count).by(-1)
        expect(response).to redirect_to categories_path
      end
    end
  end

  context 'Customer User' do
    before { sign_in user_3 }

    describe 'GET index' do
      before { get :index }

      specify do
        expect(assigns(:categories)).to eq [category_1, category_2]
        expect(response).to render_template(:index)
      end
    end

    describe 'GET show' do
      specify do
        get :show, params: { id: category_1.id }
        expect(response).to render_template(:show)
        expect(assigns(:category)).to eq category_1
      end
    end

    describe 'GET new' do
      specify do
        get :new
        expect(response).not_to render_template(:new)
      end
    end

    describe 'GET edit' do
      specify do
        get :edit, params: { id: category_1.id }
        expect(response).not_to render_template(:edit)
      end
    end

    describe 'POST create' do
      let(:params) do
        {
          name: 'category 3',
          enabled: false
        }
      end

      specify do
        expect do
          post :create, params: { category: params }
        end.not_to change { Category }
        expect(response).not_to redirect_to categories_path
      end
    end

    describe 'PATCH update' do
      let(:params) do
        {
          name: 'category 4',
          enabled: true
        }
      end

      before {
        patch :update, params: { category: params, id: category_1.id }
      }

      specify do
        expect do
          category_1.reload
        end.not_to change { category_1 }
        expect(response).not_to redirect_to categories_path
      end
    end

    describe 'DELETE destroy' do
      specify do
        expect do
          delete :destroy, params: { id: category_1.id }
        end.not_to change { Category }
        expect(response).not_to redirect_to categories_path
      end
    end
  end
end
