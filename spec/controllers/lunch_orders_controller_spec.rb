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

  describe 'GET new' do
    specify do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    specify do
      get :edit, params: { id: lunch_order_2.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        order_date: Date.today + 5
      }
    end

    context 'success' do
      specify do
        expect do
          post :create, params: { lunch_order: params }
        end.to change(LunchOrder, :count).by(1)
        lunch_order = LunchOrder.last
        expect(lunch_order.order_date).to eq Date.today + 5
        expect(response).to redirect_to(lunch_orders_path)
      end
    end

    context 'failure' do
      before {
        allow_any_instance_of(LunchOrder).to receive(:save).and_return(false)
      }

      specify do
        expect do
          post :create, params: { lunch_order: params }
        end.not_to change(LunchOrder, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH update' do
    let(:params) do
      {
        order_date: Date.today + 3
      }
    end

    context 'success' do
      before {
        patch :update, params: { lunch_order: params, id: lunch_order_2.id }
      }

      specify do
        lunch_order_2.reload
        expect(lunch_order_2.order_date).to eq(Date.today + 3)
        expect(response).to redirect_to(lunch_orders_path)
      end
    end

    context 'failure' do
      before {
        allow_any_instance_of(LunchOrder).to receive(:update).and_return(false)
      }

      specify do
        expect do
          patch :update, params: { lunch_order: params, id: lunch_order_2.id }
        end.not_to change { lunch_order_2 }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    specify do
      expect do
        delete :destroy, params: { id: lunch_order_2.id }
      end.to change(LunchOrder, :count).by(-1)
      expect(response).to redirect_to(lunch_orders_path)
    end
  end
end
