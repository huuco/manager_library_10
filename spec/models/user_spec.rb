require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  subject {user}

  context "user is invalid" do
    user = FactoryBot.build :user, :invalid_email
    it "invalid email" do
      expect(user).not_to be_valid
    end
  end

  context "when email is not valid" do
    before {subject.email = ""}
    it {is_expected.not_to be_valid}
  end

  context "when email is too long" do
    before {subject.email = Faker::Internet.email(Faker::Lorem.characters(126))}
    it {is_expected.not_to be_valid}
  end

  context "when password is not valid" do
    before {subject.password = ""}
    it {is_expected.not_to be_valid}
  end

  context "when password is too short" do
    before {subject.password = Faker::Lorem.characters(5)}
    it {is_expected.not_to be_valid}
  end

  context "validate" do
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_length_of(:email).is_at_most 125}
    it {is_expected.to validate_presence_of(:password)}
    it {is_expected.to validate_length_of(:password).is_at_least 6}
  end
end
