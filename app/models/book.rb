class Book < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  has_many :likes, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :borrows
  belongs_to :category
  belongs_to :author
  belongs_to :publisher
  
  mount_uploader :picture, PictureUploader
  validates :title, :status, presence: true

  scope :created_at_desc, -> {order created_at: :desc}
  scope :search, (lambda do |params|
    select(:id, :title, :describe, :published_at, :status, :picture, :author_id,
      "`authors`.`name` AS author_name")
    .joins(:category, :author, :publisher)
    .where '(books.title LIKE ? OR authors.name LIKE ?) AND categories.title LIKE ? AND publishers.name LIKE ?',
      "%#{params[:search]}%", "%#{params[:search]}%",
      "%#{params[:ctg_title]}%", "%#{params[:pub_name]}%"
  end)
  scope :suggest_books, (lambda do |book|
    where("category_id = ? AND id != ?", book.category_id, book.id).sample(3)
  end)
  scope :new_books, -> {order(created_at: :desc).limit 6}
  scope :outstanding_books, (lambda do
    joins(:likes)
    .where("DATE(likes.created_at) BETWEEN (CURDATE() - INTERVAL 30 DAY) AND CURDATE()")
    .group("books.id").order("count(*) desc").limit 4
  end)
  scope :most_borrow_books, (lambda do
    joins(:borrows)
    .where("DATE(borrows.created_at) BETWEEN (CURDATE() - INTERVAL 30 DAY) AND CURDATE()")
    .group("books.id").order("count(*) desc").limit 6
  end)
end
