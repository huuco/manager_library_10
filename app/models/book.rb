class Book < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags
  has_many :likes, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :borrows
  belongs_to :category
  belongs_to :author
  belongs_to :publisher
  
  mount_uploader :picture, PictureUploader

  validates :title, :status, presence: true

  scope :select_books, (lambda do 
    select(:id, :title, :published_at, :status, :picture)
    .order(created_at: :desc).includes(:author)
  end)
end
