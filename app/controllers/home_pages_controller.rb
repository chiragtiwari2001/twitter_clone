class HomePagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @posts = Post.where(user_id: current_user.following)
                 .or(Post.where(user_id: current_user.id))
                 .order(created_at: :desc)
    @post = current_user.posts.build if user_signed_in?
  end

  def notification
    set_notifications
    # debugger
  end
end
