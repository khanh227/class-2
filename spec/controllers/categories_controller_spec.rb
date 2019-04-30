require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category_1) { create(:category) }
  let!(:category_2) { create(:category) }

  describe 'GET index' do
    specify do
      get :index
      expect(assigns(:categories)).to eq [category_1, category_2]
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    specify do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
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
          post :create, params: {category: params}
        end.to change(Category, :count).by(1)
        category = Category.last
        expect(category.name).to eq 'category 3'
        expect(category.enabled).to eq false
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'failure' do
      before {
        allow_any_instance_of(Category).to receive(:save).and_return(false)
      }

      specify do
        expect do
          post :create, params: {category: params}
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
        patch :update, params: {category: params, id: category_1.id}
      }

      specify do
        category_1.reload
        expect(category_1.name).to eq('category 4')
        expect(category_1.enabled).to eq(true)
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'failure' do
      before {
        allow_any_instance_of(Category).to receive(:update).and_return(false)
      }

      specify do
        expect do
          patch :update, params: {category: params, id: category_1.id}
        end.not_to change {category_1}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    specify do
      expect do
        delete :destroy, params: {id: category_1.id}
      end.to change(Category, :count).by(-1)
      expect(response).to redirect_to(categories_path)
    end
  end
end
