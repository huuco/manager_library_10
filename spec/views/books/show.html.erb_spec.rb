require "rails_helper"

describe "books/show" do
  let!(:book) {FactoryBot.create :book}

  it "should show book" do
    assign(:book, book)
    render
    rendered.should contain book.title
  end
end
