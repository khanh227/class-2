require 'rails_helper'

RSpec.describe LunchOrdersController, type: :controller do
  let!(:user) { create(:user) }

  let!(:lunch_order_1) { create(:lunch_order, order_date: Date.today) }
  let!(:lunch_order_2) { create(:lunch_order, order_date: Date.today + 1) }

  before { sign_in user }

  describe 'GET index' do
    before { get :index }

    specify do
      expect(assigns(:lunch_orders)).to eq [lunch_order_2, lunch_order_1]
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    specify do
      get :show, params: { id: lunch_order_1.id }
      expect(response).to render_template(:show)
      expect(assigns(:lunch_order)).to eq lunch_order_1
    end
  end
end
