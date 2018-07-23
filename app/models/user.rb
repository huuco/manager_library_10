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
  scope :get_by_name_email, (lambda do |search|
    where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
  end)

  def is_role
    if self.role == 0
      return I18n.t("admin.users.show.user")
    else
      self.role == 1 ? I18n.t("admin.users.show.manager") : I18n.t("admin.users.show.admin")
    end
  end

  def admin?
    self.role == 2 ? true : false
  end

  def manager?
    self.role == 0 ? false : true
  end
end
