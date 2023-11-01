class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many_attached :images
end
