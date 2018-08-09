class Publisher < ApplicationRecord
  has_many :books

  validates :name, presence: true, length: {maximum: 150}

  scope :select_publishers, -> {includes(:books).select :id, :name, :address, :phone, :info}
  scope :search, -> name {where "name LIKE ?", "%#{name}%"}
end
