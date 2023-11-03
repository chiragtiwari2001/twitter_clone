module PostsHelper
  def liked_post?(user, post)
    post.likes.exists?(user_id: user.id)
  end
end
