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
end
