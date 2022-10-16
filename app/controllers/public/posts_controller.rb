class Public::PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def detail
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :detail
    end
  end

  def show
  end

  def edit
  end

  def search
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :start_station, :end_station, :body, :spot)
  end
end
