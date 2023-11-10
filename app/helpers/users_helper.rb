module UsersHelper
  def premium_user?(user)
    user.subscription_status == "active"
  end
end
