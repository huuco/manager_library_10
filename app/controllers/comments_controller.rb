class CommentsController < ApplicationController
  before_action :get_book, :logged_in?
  
  def create
    @comment = @book.comments.build comment_params
    @comment.user = current_user
    @comment.save ? @new_comment = @book.comments.new : @new_comment = @comment
    respond_to {|format| format.js}
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comments = @book.comments.order(created_at: :desc)
    @comment.destroy
    respond_to {|format| format.js}
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def get_book
    @book = Book.find_by id: params[:book_id]
    return if @book
      flash[:warning] = t ".not_found"
      redirect_to admin_books_path
  end
end
