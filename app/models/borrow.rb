class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  enum status: %i{waitting active refuse cancelled returned}

  validates :date_borrow, :borrow_days, presence: true

  scope :search_borrows, (lambda do |params|
    select("borrows.*, users.name AS user_name, books.title AS book_title")
    .joins(:user, :book)
    .where("users.name LIKE ? AND books.title LIKE ?",
      "%#{params[:user_name]}%", "%#{params[:book_title]}%")
    .order(created_at: :desc)
  end)
  scope :get_by_status, -> status {where status: status}
  scope :get_by_date_borrow, (lambda do |params|
    where "date_borrow BETWEEN ? AND ?", params[:from_date], params[:to_date]
  end)
end
