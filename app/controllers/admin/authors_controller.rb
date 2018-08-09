class Admin::AuthorsController < AdminController
  before_action :get_author, except: %i(index new create)

  def index
    @authors = Author.select_authors.search params[:search]
    respond_to do |format|
      format.html
      format.js
    end
    @authors = @authors.order(created_at: :desc)
                       .page(params[:page]).per Settings.pages.per_ctg
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:success] = "#{t(".add_success")} #{@author.name}"
      redirect_to admin_author_path(@author)
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @author.update_attributes author_params
      flash[:success] = t ".update_success"
      redirect_to admin_author_path
    else
      render :edit
    end
  end

  def destroy
    unless @author.books.any?
      if @author.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_fail"
      end
    else
      flash[:danger] = t ".pub_has_books"
    end
    redirect_to admin_authors_path
  end
  
  private

  def author_params
    params.require(:author).permit :name, :birth_year, :country
  end

  def get_author
    @author = Author.find_by id: params[:id]
    return if @author
      flash[:danger] = t "not_found" + params[:id]
      redirect_to admin_authors_path
  end
end
