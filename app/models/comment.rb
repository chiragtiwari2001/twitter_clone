class Comment < ApplicationRecord
  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications

  has_noticed_notifications model_name: "Notification"

  belongs_to :user
  belongs_to :post

  def self.ransackable_attributes(auth_object = nil)
    ["comment", "created_at", "id", "post_id", "updated_at", "user_id"]
  end

  private

    def notify_recipient
      CommentNotification.with(comment: self, post: post).deliver_later(post.user)
    end

    def cleanup_notifications
      notification_as_comment.destroy_all
    end
end
