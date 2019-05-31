require 'rails_helper'

RSpec.describe LunchOrder, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:customer_orders).dependent(:destroy) }
  end
end
