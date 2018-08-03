class BooksController < ApplicationController
  def index
    @books = Book.search(params[:search]).created_at_desc
    @books = @books.get_by_category params[:ctg_id] if params[:ctg_id].present?
    @books = @books.get_by_publisher params[:pub_id] if params[:pub_id].present?
    
    @books = @books.page(params[:page]).per Settings.pages.per_book
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
