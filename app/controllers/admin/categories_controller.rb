class Admin::CategoriesController < AdminController
  def index
    @categories = if params[:search].present?
      Category.select_categories.get_by_title params[:search]
    else
      Category.select_categories
    end
    @categories = @categories.order(:title)
                             .page(params[:page]).per Settings.pages.per_ctg
  end
end
