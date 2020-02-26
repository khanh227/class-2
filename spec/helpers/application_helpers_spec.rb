require 'rails_helper'

describe ApplicationHelper, type: :helper do

  describe '#app_name' do 
    it{ expect( helper.app_name).to eq "Lunch Service" }
  end

  describe "#display_status" do
    context 'when status not nil'do
      it{ expect(helper.display_status('abc')).to eq "<span class=\"glyphicon glyphicon-ok\"></span>" }
    end
    context 'when status nil' do
      it{ expect(helper.display_status(nil)).to eq "<span class=\"glyphicon glyphicon-remove\"></span>" }
    end
  end
end
