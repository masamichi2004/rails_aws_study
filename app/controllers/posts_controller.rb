class PostsController < ApplicationController
  before_action :set_post, only: [ :edit, :update, :destroy ]
  def index
    @posts = Post.all
    render json: @posts
  end

  def new
    @post = Post.new
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def edit
    render json: @post
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render json:
      {
        message: "Post Deleted Successfully",
        status: :ok,
        post: { post_id: @post.id, post_title: @post.title }
      }
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
