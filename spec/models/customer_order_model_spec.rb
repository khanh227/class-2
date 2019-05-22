require 'rails_helper'

RSpec.describe CustomerOrder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:lunch_order) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:lunch_order_id) }
  end

  describe '#update_attribute' do
    let!(:user) { create(:user, email: 'test_1@test.email') }

    context 'update success' do
      specify do
        expect do
          user.update_attribute(:email, 'test_2@test.email')
        end.to change(user, :email).to 'test_2@test.email'
      end
    end

    context 'update failure' do
      before {
        allow_any_instance_of(User).to receive(:update_attribute).and_return(false)
      }

      specify do
        expect do
          user.update_attribute(:email, 'test_2@test.email')
        end.not_to change(user, :email)
      end
    end
  end
end
