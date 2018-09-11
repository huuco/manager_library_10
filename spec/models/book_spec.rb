require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "Validations" do
    subject { FactoryBot.create :book }
    it "is valid with valid attributes" do
      is_expected.to be_valid
    end
    
    it "is not valid without a title" do
	    subject.title = nil
      is_expected.to_not be_valid
    end
  end

  describe "Associations" do
    it "belongs to author" do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end
  end
end
