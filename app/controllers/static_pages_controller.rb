class StaticPagesController < ApplicationController
  def home
    @ost_books = Book.outstanding_books
    @new_books = Book.new_books
    @br_books = Book.most_borrow_books
  end
end
