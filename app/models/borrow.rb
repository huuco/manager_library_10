class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  enum status: %i{waitting active refuse cancelled returned lated}

  validates :date_borrow, :borrow_days, presence: true

  scope :get_borrow, (lambda do |bor_id|
    select("borrows.*, users.id AS user_id, users.name AS user_name,
      books.id AS book_id, books.title AS book_title, books.status AS book_status")
    .joins(:user, :book).find_by id: bor_id
  end)
  scope :search_borrows, (lambda do |params|
    select("borrows.*, users.id AS user_id, users.name AS user_name,
      books.id AS book_id, books.title AS book_title, books.status AS book_status")
    .joins(:user, :book)
    .where("users.name LIKE ? AND books.title LIKE ?",
      "%#{params[:user_name]}%", "%#{params[:book_title]}%")
    .order(created_at: :desc)
  end)
  scope :get_by_status, -> status {where status: status}
  scope :get_by_date_borrow, (lambda do |params|
    where "date_borrow BETWEEN ? AND ?", params[:from_date], params[:to_date]
  end)
  scope :count_borrows, (lambda do
    where "EXTRACT(YEAR_MONTH FROM date_borrow) = EXTRACT(YEAR_MONTH FROM CURDATE()) - 1"
  end)
  scope :count_accepts, (lambda do
    where "(EXTRACT(YEAR_MONTH FROM date_borrow) = EXTRACT(YEAR_MONTH FROM CURDATE()) - 1) AND status IN (1, 4)"
  end)
  scope :count_returns, (lambda do
    where "EXTRACT(YEAR_MONTH FROM date_return) = EXTRACT(YEAR_MONTH FROM CURDATE()) - 1"
  end)
end
