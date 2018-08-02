class BorrowsController < ApplicationController
  before_action :get_book

  def new
    @borrow = Borrow.new
    respond_to {|format| format.js}
  end

  def create
    if @book.status
      @borrow = @book.borrows.build borrow_params
      @borrow.user = current_user
      if @borrow.save
        flash[:success] = "#{t(".borrow")} #{@book.title}"
      else
        flash[:error] = "#{t(".borrow_fail")} #{@book.title}"
      end
    else
      flash[:danger] = "#{@book.title} #{t(".is_borrowed")}"
    end
    redirect_to @book
  end

  def update
    @borrow = Borrow.find_by id: params[:id]
    @borrow.update_attributes status: params[:status]
    respond_to {|format| format.js}
  end

  private

  def borrow_params
    params.require(:borrow).permit(:date_borrow, :borrow_days)
  end

  def get_book
    @book = Book.find_by id: params[:book_id]
  end
end
