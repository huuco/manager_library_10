class Author < ApplicationRecord
  has_many :books

  validates :name, presence: true, length: {maximum: 50}

  scope :select_authors, -> {includes(:books).select :id, :name, :birth_year, :country}
  scope :search, -> name {where "name LIKE ?", "%#{name}%"}
end
