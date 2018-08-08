class FollowsController < ApplicationController
  before_action :get_book, :user_signed_in?

  def create
    @follow = current_user.follows.build
    @follow.book = @book
    respond_to {|format| format.js} if @follow.save
  end

  def destroy
    @follow = Follow.find_by id: params[:id]
    respond_to {|format| format.js} if @follow.destroy
  end

  private

  def get_book
    @book = Book.find_by id: params[:book_id]
  end
end
