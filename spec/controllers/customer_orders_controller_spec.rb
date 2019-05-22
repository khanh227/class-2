require 'rails_helper'

RSpec.describe CustomerOrdersController, type: :controller do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let!(:customer_order_1) { create(:customer_order, user: user_1) }
  let!(:customer_order_2) { create(:customer_order, user: user_1) }
  let!(:customer_order_3) { create(:customer_order, user: user_2) }

  before { sign_in user }

  describe 'GET index' do
    let(:user) { user_1 }

    before { get :index }

    specify do
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(assigns(:customer_orders)).to eq [customer_order_1, customer_order_2]
    end
  end

  describe 'GET show' do
    let(:user) { user_2 }

    specify do
      get :show, params: { id: customer_order_3.id}
      expect(response).to render_template(:show)
      expect(assigns(:customer_order)).to eq customer_order_3
    end
  end

  describe '#cancel' do
    let(:user) { user_1 }

    context 'update success' do
      specify do
        expect do
          customer_order_1.update_attribute(:canceled_at, '10:00:00')
        end.to change(customer_order_1, :canceled_at).to eq '2000-01-01 10:00:00.000000000 +0000'
        expect(flash[:success]).to eq 'You canceled order successful!'
      end
    end

    context 'update failure' do
      before {
        allow_any_instance_of(CustomerOrder).to receive(:update_attribute).and_return(false)
      }

      specify do
        expect do
          customer_order_1.update_attribute(:canceled_at, '10:00:00')
        end.not_to change(customer_order_1, :canceled_at)
        expect(flash[:failure]).to eq 'You canceled order failure!'
      end
    end
  end
end
