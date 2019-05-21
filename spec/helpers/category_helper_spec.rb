require 'rails_helper'

describe CategoryHelper, type: :helper do
  describe '#category_list' do
    let!(:category_1) { create(:category) }
    let!(:category_2) { create(:category) }
    
    context 'sucsess' do
      specify do
        expect(category_list).to eq [[category_1.name, category_1.id], [category_2.name, category_2.id]]
      end
    end
  end
end
