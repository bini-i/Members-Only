class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = 'successfully created'
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'successfully updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @post.destroy
    flash[:notice] = 'successfully destroyed'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    return if @post.user == current_user

    flash[:alert] = 'You can edit and destroy only your own post'
    redirect_to root_path
  end
end
