class Tag < ApplicationRecord
  has_many :book_tags
  has_many :books, through: :book_tags

  validates :tag, presence: true, length: {maximum: 50}
end
