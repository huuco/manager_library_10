class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :point, presence: true
end
