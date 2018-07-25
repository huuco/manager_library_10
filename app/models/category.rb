class Category < ApplicationRecord
  has_many :books

  validates :title, presence: true, uniqueness: true, length: {maximum: 30}

  scope :select_categories, ->{select :title, :describe}
  scope :get_by_title, -> t {where("title LIKE ?", "%#{t}%")}
end
