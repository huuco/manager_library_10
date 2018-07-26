class BooksController < ApplicationController
  def index
    @books = Book.search(params).created_at_desc
                 .page(params[:page]).per Settings.pages.per_book
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find_by id: params[:id]
    @comments = @book.comments.created_at_desc
    @sg_books = Book.suggest_books @book
  end
end
