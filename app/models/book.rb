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

  scope :select_books, (lambda do
    includes(:likes, :borrows, :follows)
    .select(:id, :title, :describe, :published_at, :status, :picture, :author_id,
    :category_id, :publisher_id, "authors.name AS author_name")
    .joins(:author)
  end)
  scope :created_at_desc, -> {order created_at: :desc}

  scope :search, (lambda do |search|
    select_books
    .where "books.title LIKE ? OR authors.name LIKE ?", "%#{search}%", "%#{search}%"
  end)
  scope :get_by_category, -> ctg_id {where category_id: ctg_id}
  scope :get_by_publisher, -> pub_id {where publisher_id: pub_id}

  scope :suggest_books, (lambda do |book|
    select_books.where("category_id = ? AND books.id != ?", book.category_id, book.id).sample(3)
  end)

  scope :new_books, -> {select_books.created_at_desc.limit 6}
  
  scope :outstanding_books, (lambda do
    includes(:borrows, :follows)
    .select(:id, :title, :describe, :published_at, :status, :picture, :author_id,
    :category_id, :publisher_id, "authors.name AS author_name")
    .joins(:likes, :author)
    .where("DATE(likes.created_at) BETWEEN (CURDATE() - INTERVAL 30 DAY) AND CURDATE()")
    .group("books.id").order("COUNT(books.id) desc").limit 4
  end)

  scope :most_borrow_books, (lambda do
    includes(:likes, :follows)
    .select(:id, :title, :describe, :published_at, :status, :picture, :author_id,
    :category_id, :publisher_id, "authors.name AS author_name")
    .joins(:borrows, :author)
    .where("DATE(borrows.created_at) BETWEEN (CURDATE() - INTERVAL 30 DAY) AND CURDATE()")
    .group("books.id").order("COUNT(books.id) desc").limit 6
  end)
end
