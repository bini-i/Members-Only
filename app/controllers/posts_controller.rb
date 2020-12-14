class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :get_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        if @post.save
            flash[:notice] = "successfully created"
            redirect_to @post
        else
            render "new"
        end
    end
    
    def update
        if @post.update(post_params)
            flash[:notice] = "successfully updated"
            redirect_to @post
        else
            render "edit"
        end
              
    end

    def edit

    end

    def destroy
        @post.destroy
        flash[:notice] = "successfully destroyed"
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def get_post
        @post = Post.find(params[:id])
    end
end
