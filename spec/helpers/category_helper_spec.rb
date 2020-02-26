require "rails_helper"

RSpec.describe CategoryHelper , type: :helper do
  let!(:category_1) { create(:category, name: "name 1",enabled: false) }
  let!(:category_2) { create(:category, name: "name 2",enabled: true) }
  let!(:category_3) { create(:category, name: "name 3",enabled: false) }
  let!(:category_4) { create(:category, name: "name 4",enabled: true) }

  describe '#category_list' do
    it do
      expect(helper.category_list).to eq [["name 2",category_2.id], ["name 4",category_4.id] ]
      expect(helper.category_list).not_to eq [["name 1",category_1.id], ["name 3",category_3.id]]
    end
  end
end
