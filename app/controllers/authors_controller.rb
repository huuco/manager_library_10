class AuthorsController < ApplicationController
  def index
    @authors = Author.select_authors
  end

  def show
    @author = Author.find_by id: params[:id]
    @books = @author.books.select_books
  end
end
