class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :notification, through: :user, dependent: :destroy
  has_noticed_notifications model_name: "Notification"

  belongs_to :user

  has_many_attached :images

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "images_attachments", "images_blobs", "user"]
  end
end
