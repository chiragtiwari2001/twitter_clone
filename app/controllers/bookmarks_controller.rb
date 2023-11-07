class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmark_posts
  end

  def create
    @post = Post.find(params[:post_id])
    current_user.bookmark_posts << @post
    flash[:success] = "Post added to bookmarks!"
    redirect_to request.referrer
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    flash[:success] = "Post removed from the bookmark!"
    redirect_to request.referrer
  end
end
