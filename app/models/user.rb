class User < ApplicationRecord
  after_create :assign_default_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :avatar
  has_one_attached :profile_background

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end
