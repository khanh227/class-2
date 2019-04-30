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

  describe 'GET #new' do
    specify do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:params) do
      {
        name: 'name_3',
        enabled: false
      }
    end
    context 'success' do
      specify do
        expect do
          post :create, params: {category: params}
          end.to change(Category, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(categories_path)
        expect(Category.last.name).to eq 'name_3'
        expect(Category.last.enabled).to eq false
      end
    end
    context 'failure' do
      specify do
        allow_any_instance_of(Category).to receive(:save).and_return(false)
        expect do
          post :create, params: {category: params}
          end.not_to change(Category, :count)
        expect(response).not_to have_http_status(302)
        expect(response).to render_template(:new)
      end
    end
  end
end
