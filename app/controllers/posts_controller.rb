class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def new
    @post = Posts::Post.new
  end

  def create
    @post = Posts::Post.new(post_params)
    @post.user = User.first # for only test

    if @post.save
      redirect_to post_path(@post), notice: "Post successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @posts = Posts::Post.all
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post successfully deleted!"
  end

  private

  def set_post
    @post = Posts::Post.find(params[:id])
  end

  def post_params
    params.require(:posts_post).permit(:title, :body, :post_type, :photo)
  end
end
