class Borrow < ApplicationRecord
  belongs_to :user

  validates :date_borrow, :borrow_days, presence: true
end
