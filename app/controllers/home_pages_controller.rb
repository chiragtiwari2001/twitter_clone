class HomePagesController < ApplicationController
  before_action :authenticate_user!

  def home
  @posts = Post.all.order(created_at: :desc)
    @post = current_user.posts.build if user_signed_in?
  end
end
