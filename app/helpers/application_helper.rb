module ApplicationHelper
  def admin?
    current_user.has_role? :admin
  end
end
