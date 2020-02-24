require 'rails_helper'

describe MenuHelper, type: :helper do
  let!(:menu_1) { create(:menu, menu_name: "menu 1")}
  let!(:menu_2) { create(:menu, menu_name: "menu 2")}
  let!(:menu_3) { create(:menu, menu_name: "menu 3")}
  let!(:menu_4) { create(:menu, menu_name: "menu 4")}

  describe '#menu_list' do
    specify do
      expect(helper.menu_list).to eq [["menu 1", 1], ["menu 2", 2], ["menu 3", 3], ["menu 4", 4]]
    end
  end

  describe '#display_background_img'do
    context 'when no background_img' do
      before do
        allow_any_instance_of(Menu).to receive(:background_img).and_return(:false)
        expect(helper.display_background_img(:background_img)).to eq ('')
      end 
    end
    context 'when has background_img' do
      before do
        allow_any_instance_of(Menu).to receive(:background_img).and_return(:true)
        expect(helper.display_background_img(:background_img)).to eq (url_for(menu.background_img))
      end
    end
  end
end
