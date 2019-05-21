require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).with_foreign_key('created_by') }
  end

  describe '#products' do
    let!(:menu_1) { create(:menu) }
    let!(:menu_2) { create(:menu) }

    specify do
      expect(menu_1.products).to eq menu_1.product_ids
      expect(menu_2.products).to eq menu_1.product_ids
      expect(menu_1.products).to eq menu_2.product_ids
    end
  end
end
