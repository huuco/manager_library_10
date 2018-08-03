class Category < ApplicationRecord
  belongs_to :parent, class_name: "Category"
  has_many :books
  has_many :children, class_name: "Category", foreign_key: :parent_id

  validates :title, presence: true, uniqueness: true, length: {maximum: 30}

  scope :select_categories, ->{includes(:books).select :id, :title, :describe}
  scope :get_by_title, -> title {where("title LIKE ?", "%#{title}%")}
  scope :get_parent, -> {includes(:children).where parent_id: nil}

  def is_parent?
    !!self.parent.nil?
  end

  def has_parent?
    !!self.parent.present?
  end
end
