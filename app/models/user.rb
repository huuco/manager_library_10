class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :borrows
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy

  enum role: %i{user manager admin}
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  scope :get_by_role, -> role {where role: role}
  scope :select_users, ->{includes(:borrows).select :id, :name, :email, :created_at}
  scope :get_by_name_email, (lambda do |search|
    where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
  end)
  
  def self.to_csv options = {}
    CSV.generate(options) do |csv|
      desired_columns = [I18n.t("admin.users.index.name"),
                         I18n.t("admin.users.index.email"),
                         I18n.t("admin.users.index.joined")]
      csv << desired_columns
      all.each do |user|
        row = [user.name, user.email, user.created_at.strftime("%d-%m-%Y")]
        csv << row
      end
    end
  end

  def self.from_omniauth auth
    data = auth.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create(
        uid: auth.uid,
        name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
