class Category < ApplicationRecord
  has_many :books

  validates :title, presence: true, length: {maximum: 30}
end
