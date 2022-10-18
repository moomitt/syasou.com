class Public::PostsController < ApplicationController
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
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @all_posts = Post.all
    @map_posts = Array::new
    @all_posts.each do |post|
      @map_posts.push({"post_id" => post.id, "post_body" => post.body, "start_station" => post.start_station, "end_station" => post.end_station, "line_code" => post.line_code})
    end
  end

  def search
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :start_station, :end_station,
    :start_station_prefecture, :end_station_prefecture, :line_code,
    :body, :time_zone, :spot)
  end
end
