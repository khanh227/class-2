require 'cancan/matchers'
require 'rails_helper'

describe "User" do
  describe "abilities" do
    context 'admin' do
      let!(:user_1) { create(:user, role_user: 'admin') }
      subject(:ability_1) { Ability.new(user_1) }
      it { should be_able_to(:manage, Product) }
    end

    context 'restaurant' do
      let!(:user_1) { create(:user, role_user: 'restaurant') }
      subject(:ability_1) { Ability.new(user_1) }
      it { should be_able_to([:create, :read, :update, :destroy], Product) }
    end

    context 'customer' do
      let!(:user_1) { create(:user, role_user: 'customer') }
      subject(:ability_1) { Ability.new(user_1) }
      it { should be_able_to(:read, Product) }
    end
  end
end
