class Admin::BorrowsController < AdminController
  
  def index
    @borrows = Borrow.search_borrows params
    if params[:from_date].present? && params[:to_date].present?
      @borrows = @borrows.get_by_date_borrow params
    end
    @borrows = @borrows.get_by_status params[:status] if params[:status].present?
    @borrows = @borrows.page(params[:page]).per Settings.pages.per_ctg
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @borrow = Borrow.get_borrow params[:id]
    unless @borrow.cancelled? || @borrow.refuse?
      if @borrow.book_status && params[:status] == "active"
        @borrow.book.toggle! :status
        update_borrow @borrow
      elsif !@borrow.book_status && params[:status] == "returned"
        @borrow.book.toggle! :status
        @borrow.update_attributes date_return: Date.today
        update_borrow @borrow
      elsif params[:status] == "refuse"
        update_borrow @borrow
      end
    end
    respond_to do |format|
      format.html {redirect_to admin_borrows_path}
      format.js
    end
  end

  private

  def update_borrow borrow
    borrow.update_attributes status: params[:status]
    BorrowMailer.update_borrow_email(borrow.user, borrow).deliver_later
  end
end
