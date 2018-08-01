module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def serial_number page, per_page
    @idx = page == 0 ? 0 : (page - 1) * per_page
  end

  def liked? book_id
    current_user.likes.find_by(book_id: book_id).present?
  end

  def followed? book_id
    current_user.follows.find_by(book_id: book_id).present?
  end
end
