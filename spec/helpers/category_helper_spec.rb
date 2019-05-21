require 'rails_helper'

describe CategoryHelper, type: :helper do
  describe '#category_list' do
    let!(:category_1) { create(:category, enabled: true) }
    let!(:category_2) { create(:category, enabled: true) }
    let!(:category_3) { create(:category, enabled: false) }
    
    context 'when enabled = true' do
      specify do
        expect(category_list).to eq [[category_1.name, category_1.id], [category_2.name, category_2.id]]
      end
    end

    context 'when enabled = false' do
      specify do
        expect(category_list).not_to eq [[category_1.name, category_1.id], [category_3.name, category_3.id]]
      end
    end
  end
end
