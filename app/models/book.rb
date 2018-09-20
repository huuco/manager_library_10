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
    .select("books.*, authors.name AS author_name")
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
    .select("books.*, authors.name AS author_name")
    .joins(:author, :likes)
    .where("likes.created_at BETWEEN (CURRENT_DATE - 30) AND (CURRENT_DATE + 1)")
    .group("books.id, author_name").order("COUNT(*) desc").limit 4
  end)

  scope :most_borrow_books, (lambda do
    includes(:likes, :follows)
    .select("books.*, authors.name AS author_name")
    .joins(:author, :borrows)
    .where("borrows.created_at BETWEEN (CURRENT_DATE - 30) AND (CURRENT_DATE + 1)")
    .group("books.id, author_name").order("COUNT(*) desc").limit 6
  end)

  def atr_name=(name)
    @atr_name = name
    self.author = Author.find_or_initialize_by(name: name)
  end

  def atr_name
    @atr_name
  end

  def pub_name=(name)
    @pub_name = name
    self.publisher = Publisher.find_or_initialize_by(name: name)
  end

  def pub_name
    @pub_name
  end
end
