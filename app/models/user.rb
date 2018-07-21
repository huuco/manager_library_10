class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :borrows
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.email.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.email.maximum}, format: {with: VALID_EMAIL_REGEX}
         
  before_save {email.downcase!}
  has_secure_password

  scope :get_by_role, -> role {where role: role}
  scope :select_users, ->{select :id, :name, :email, :created_at}
end
