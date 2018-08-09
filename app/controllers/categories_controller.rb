class CategoriesController < ApplicationController
  def index
    @categories = Category.get_parent.select_categories
  end

  def show
    @category = Category.find_by id: params[:id]
    @books = @category.books.select_books
  end
end
