class Admin::BorrowsController < AdminController
  
  def index
    @data = Borrow.group(:status).group_by_day(:created_at).count
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
    if @borrow.waitting?
      if @borrow.book_status && params[:status] == "active"
        update_borrow_book @borrow
      elsif params[:status] == "refuse"
        update_borrow @borrow
      end
    elsif @borrow.active? || @borrow.lated?
      if !@borrow.book_status && params[:status] == "returned"
        @borrow.update_attributes date_return: Date.today
        update_borrow_book @borrow
      end
    end
    respond_to do |format|
      format.html {redirect_to admin_borrows_path}
      format.js
    end
  end

  private

  def update_borrow borrow
    if borrow.update_attributes status: params[:status]
      BorrowMailer.update_borrow_email(borrow.user, borrow).deliver_later
    end
  end

  def update_borrow_book borrow
    update_borrow borrow
    borrow.book.toggle! :status
  end
end
