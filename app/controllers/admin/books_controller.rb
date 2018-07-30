class Admin::BooksController < ApplicationController
  before_action :get_book, except: [:index, :new, :create]

  def index
    @books = Book.select_books.page(params[:page]).per Settings.pages.per_book
  end

  def new
    @book = Book.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t ".create_success"
      redirect_to admin_books_path
    else
      flash[:error] = t ".create_fail"
      redirect_to admin_books_path
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t ".update_success"
      redirect_to admin_books_path
    else
      flash[:error] = t ".update_fail"
      render "edit"
    end
  end

  def destroy
    unless @book.status
      if @book.destroy
        flash[:success] = t ".delete_success"
        redirect_to admin_books_url
      else
        flash[:danger] = t ".delete_fail"
        redirect_to admin_book_path(@book)
      end
    else
      flash[:danger] = t ".not_delete"
      redirect_to admin_book_path(@book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :describe, :published_at,
      :category_id, :author_id, :publisher_id, :picture)
  end

  def get_book
    @book = Book.find_by id: params[:id]
    return if @book
      flash[:warning] = t ".not_found"
      redirect_to admin_books_path
  end
end
