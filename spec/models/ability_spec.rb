require 'rails_helper'
require 'cancan/matchers'

describe User do
  let(:ability) { Ability.new(user) }

  describe 'admin user' do
    let(:user) { create(:user, role_user: :admin) }

    specify do
      expect(ability).to be_able_to(:manage, :all)
    end
  end

  describe 'restaurant user' do
    let(:user) { create(:user, role_user: :restaurant) }

    specify do
      expect(ability).to be_able_to(:create, Product)
      expect(ability).to be_able_to(:read, Product)
      expect(ability).to be_able_to(:update, Product)
      expect(ability).to be_able_to(:destroy, Product)
    end
  end

  describe 'customer user' do
    let(:user) { create(:user, role_user: :customer) }

    specify do
      expect(ability).not_to be_able_to(:create, Product)
      expect(ability).not_to be_able_to(:update, Product)
      expect(ability).not_to be_able_to(:destroy, Product)
      expect(ability).to be_able_to(:read, Product)
    end
  end
end
