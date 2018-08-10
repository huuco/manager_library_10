class Admin::CategoriesController < AdminController
  before_action :get_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.select_categories.get_by_title(params[:search])
                          .order(:title).includes(:books)
                          .page(params[:page]).per Settings.pages.per_ctg
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "#{t(".add_success")} #{@category.title}"
      redirect_to admin_categories_path
    else
      flash[:error] = t ".add_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    unless @category.books.any?
      if @category.destroy
        flash[:success] = t ".delete_success"
      else
        flash[:danger] = t ".delete_fail"
      end
    else
      flash[:danger] = t ".ctg_has_books"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :describe, :parent_id)
  end

  def get_category
    @category = Category.find_by id: params[:id]
    return if @category
      flash[:danger] = t "not_found" + params[:id]
      redirect_to admin_categories_path
  end
end
