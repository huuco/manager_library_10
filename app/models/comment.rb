class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true

  scope :created_at_desc, -> {order created_at: :desc} 
end
