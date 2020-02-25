require "rails_helper"
RSpec.describe Category , type: :model do

  context "associations" do
    it { should have_many (:products)}
  end

  context "validates" do
    subject {
    	described_class.new(name: "Anything",
    						 					presence: true,
    						 					length: { minimum: 5 })
    	it "is valid with valid attributes" do
    		expect(subject).to be_valid
    	end
      it "is not valid without a name" do
       	subject.name = nil
    			expect(subject).to_not be_valid
  		end
  		it "is not valid without length minimum 5 characters" do
  			subject.length >= 5
  				expect(subject).to_not be_valid 
  		end
  	}
    end
end
