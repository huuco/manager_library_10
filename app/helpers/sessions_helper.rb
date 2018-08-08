module SessionsHelper
  def serial_number page, per_page
    @idx = page == 0 ? 0 : (page - 1) * per_page
  end

  def liked? book_id
    current_user.likes.find_by(book_id: book_id).present?
  end

  def followed? book_id
    current_user.follows.find_by(book_id: book_id).present?
  end

  def waitting_borrow? book_id
    borrow = current_user.borrows.find_by book_id: book_id
    return borrow.present? && borrow.waitting?
  end
end
