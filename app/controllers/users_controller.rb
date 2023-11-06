class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show followers following follow unfollow]

  def show; end

  def followers
    @user_followers = @user.followers
  end

  def following
    @user_following = @user.following
  end

  def follow
    current_user.following << @user
    flash[:success] = "You are now following #{@user.username}."
    redirect_to request.referrer
  end

  def unfollow
    current_user.following.delete(@user)
    flash[:success] = "unfollowed #{@user.username} successfully!"
    redirect_to request.referrer
  end

  def explore; end

  def search
    @search = params[:query]
    @users = User.where("username LIKE ?", "%#{@search}%") unless @search.blank?
    render :explore 
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
