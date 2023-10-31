class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update]
  before_action :correct_user, only: :destroy

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      render :new, status: :see_other
    end
  end

  def edit; end

  def update

    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render :edit, status: :see_other
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post Deleted!"
    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:content, images: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_path if @post.nil?
    end
end
