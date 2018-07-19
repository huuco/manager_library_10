class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence: true, length: {maximum: 150}
end
