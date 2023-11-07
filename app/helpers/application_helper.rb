module ApplicationHelper
  def admin?
    current_user.has_role? :admin
  end

  def following?(user, other_user)
    user.following.include?(other_user)
  end

  def bookmarked?(post)
    current_user.bookmark_posts.include?(post)
  end
end
