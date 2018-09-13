require "rails_helper"

describe "users/show" do
  let!(:user) {FactoryBot.create :user, :user}

  it "should show users" do
    assign(:user, user)
    render
    expect(rendered).to match user.email
  end
end
