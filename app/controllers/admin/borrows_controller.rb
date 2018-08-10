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
    @borrow = Borrow.find_by id: params[:id]
    book = @borrow.book
    if @borrow.update_attributes status: params[:status]
      unless params[:status] == "refuse"
        book.toggle! :status
        @borrow.update_attributes date_return: Date.today if params[:status] == "returned"
      end
      BorrowMailer.update_borrow_email(@borrow.user, @borrow).deliver_later
    end
    respond_to do |format|
      format.html {redirect_to admin_borrows_path}
      format.js
    end
  end
end
