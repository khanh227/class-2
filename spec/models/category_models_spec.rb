require "rails_helper"

RSpec.describe Category , type: :model do

  describe "associations" do
    it { should have_many (:products)}
  end

  describe "validates" do
    subject {
      described_class.new(name: "Anything",
                          presence: true,
                          length: { minimum: 5 })

      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      it "is invalid due to lack of the name" do
        subject.name = nil
          expect(subject).to_not be_valid
      end

      it "is invalid because the name length is 5 characters or more" do
        subject.length >= 5
          expect(subject).to_not be_valid 
      end
    }
    end
end
