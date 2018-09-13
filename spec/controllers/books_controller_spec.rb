require "rails_helper"

RSpec.describe Admin::BooksController, type: :controller do
  let(:book) {FactoryBot.create :book}
  subject {book}

  let(:user) {FactoryBot.create :user, :admin}
  before {sign_in user}

  describe "POST #create" do
    context "with valid attributes" do
      before {post :create, params: {book: FactoryBot.attributes_for(:book)}}
      it "creates a new book" do
        expect(assigns(:book)).to be_a_new(Book)
      end

      it "redirects after create" do
        expect(response).to redirect_to(admin_books_path)
      end
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy, params: {id: subject.id}}
    context "delete success" do
      it "test message" do
        expect(response).to redirect_to(admin_books_path)
      end
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with title " do
        patch :update, params: {id: subject.id, book: {title: "Norway Woods"}}
        expect(flash[:success]).to match(I18n.t("admin.books.update.update_success"))
        expect(response).to redirect_to(admin_book_path)
      end
    end

    context "update category" do
      it "update fail" do
        patch :update, params: {id: subject.id, book: {title: ""}}
        expect(flash[:error]).to match(I18n.t("admin.books.update.update_fail"))
        expect(response).to redirect_to(admin_book_path)
      end
    end
  end
end
