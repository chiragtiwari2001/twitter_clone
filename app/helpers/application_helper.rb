module ApplicationHelper
  def admin?
    current_user.has_role? :admin
  end

  def following?(user, other_user)
    user.following.include?(other_user)
  end
end
