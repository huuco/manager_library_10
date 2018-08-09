class Admin::BooksController < AdminController
  before_action :get_book, except: %i(index new create)

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

  def new
    @book = Book.new
    respond_to {|format| format.js}
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
    @comments = @book.comments.created_at_desc
  end

  def edit
    respond_to {|format| format.js}
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t ".update_success"
    else
      flash[:error] = t ".update_fail"
    end
    redirect_to admin_book_path(@book)
  end

  def destroy
    if @book.status
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
    params.require(:book).permit :title, :describe, :published_at,
      :category_id, :author_id, :publisher_id, :picture
  end

  def get_book
    @book = Book.find_by id: params[:id]
    return if @book
      flash[:warning] = t ".not_found"
      redirect_to admin_books_path
  end
end
