class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @comment = current_user.comments.create(comment_params)
    if @comment.save
      flash[:success] = "Commented successfuly"
      redirect_to @post
    else
      render @post, status: :see_other
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "comment deleted!"
    redirect_to @post
  end

  private

    def comment_params
      params.require(:comment).permit(:comment).merge(post_id: params[:post_id])
    end

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to @post if @comment.nil?
    end
end
