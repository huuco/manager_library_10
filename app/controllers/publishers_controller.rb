class PublishersController < ApplicationController
  def index
    @publishers = Publisher.select_publishers
  end

  def show
    @publisher = Publisher.find_by id: params[:id]
    @books = @publisher.books.select_books
  end
end
