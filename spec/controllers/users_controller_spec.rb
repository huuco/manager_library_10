require "rails_helper"

RSpec.describe UsersController, type: :controller do
  context "GET #show" do
    let(:user) {FactoryBot.create :user}
    it "render show user" do
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:ok)
      expect(response).to render_template "show"
    end
  end
end
