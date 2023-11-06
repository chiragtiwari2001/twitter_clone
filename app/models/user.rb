class User < ApplicationRecord
  after_create :assign_default_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :following

  has_many :pasive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :pasive_relationships, source: :follower

  has_one_attached :avatar
  has_one_attached :profile_background

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["confirmation_sent_at", "confirmation_token", "confirmed_at", "created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "unconfirmed_email", "updated_at", "username"]
  end

  def self.from_omniauth(auth)
    require 'open-uri'
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = auth.info.password
      user.username = auth.info.name
      if auth.info.image.present?
        io = open(auth.info.image)
        filename = File.basename(io.base_uri.path)
        content_type = io.content_type

        user.avatar.attach(io: io, filename: filename, content_type: content_type)
      end
    end
  end
end
