require "rails_helper"

RSpec.describe CategoryHelper , type: :helper do
  let!(:category_1) { create (:category, name: "name 1")}
  let!(:category_2) { create (:category, name: "name 2")}

  describe '#category_list' do
    it do
      expect(helper.category_list).to eq [["name 1",category_1.id], ["name 2",category_2.id]]
    end
  end
end
