class LikesController < ApplicationController
  before_action :get_book, :logged_in?

  def create
    @like = current_user.likes.build
    @like.book = @book
    respond_to {|format| format.js} if @like.save
  end

  def destroy
    @like = Like.find_by id: params[:id]
    respond_to {|format| format.js} if @like.destroy
  end

  private

  def get_book
    @book = Book.find_by id: params[:book_id]
  end
end
