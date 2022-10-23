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
    @new_comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        post_image = @post.post_images.find(image_id)
        post_image.purge_later
      end
    end
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.post_image.attached?
      @post.post_image.purge_later && @post.destroy
      redirect_to posts_path
    else
      @post.destroy
      redirect_to posts_path
    end
  end

  def index
    @all_posts = Post.all
    @map_posts = Array::new
    @all_posts.each do |post|
      hash = {"post_id" => post.id, "post_body" => post.body,
      "start_station" => post.start_station, "end_station" => post.end_station,
      "line_code" => post.line_code,
      "latitude" => post.latitude, "longitude" => post.longitude }
      if post.post_images.attached?
        hash["post_image"] = url_for(post.post_images[0].variant(resize_to_fill: [150, 100]))
      else
        hash["post_image"] = '/assets/no_image.png'
      end
      @map_posts.push(hash)
    end
  end

  def search_area
    if params[:id] == "1"
      @area_name = "北海道"
      @all_posts = Post.where(start_station_prefecture: 1)
      .or(Post.where(end_station_prefecture: 1))
    end
    if params[:id] == "2"
      @area_name = "東北"
      ids = [2, 3, 4, 5, 6, 7]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 2..7)
      .or(Post.where(end_station_prefecture: 2..7))
    end
    if params[:id] == "3"
      @area_name = "関東"
      ids = [8, 9, 10, 11, 12, 13, 14]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 8..14)
      .or(Post.where(end_station_prefecture: 8..14))
    end
    if params[:id] == "4"
      @area_name = "中部（中央・北陸・東海）"
      ids = [15, 16, 17, 18, 19, 20, 21, 22, 23]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 15..23)
      .or(Post.where(end_station_prefecture: 15..23))
    end
    if params[:id] == "5"
      @area_name = "近畿"
      ids = [24, 25, 26, 27, 28, 29, 30]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 24..30)
      .or(Post.where(end_station_prefecture: 24..30))
    end
    if params[:id] == "6"
      @area_name = "中国"
      ids = [31, 32, 33, 34, 35]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 31..35)
      .or(Post.where(end_station_prefecture: 31..35))
    end
    if params[:id] == "7"
      @area_name = "四国"
      ids = [36, 37, 38, 39]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 36..39)
      .or(Post.where(end_station_prefecture: 36..39))
    end
    if params[:id] == "8"
      @area_name = "九州・沖縄"
      ids = [40, 41, 42, 43, 44, 45, 46, 47]
      @prefectures = Prefecture.find(ids)
      @all_posts = Post.where(start_station_prefecture: 40..47)
      .or(Post.where(end_station_prefecture: 40..47))
    end
  end

  def search_prefecture
    if params[:id]
      @prefecture = Prefecture.find(params[:id])
      @all_posts = Post.where(start_station_prefecture: params[:id])
      .or(Post.where(end_station_prefecture: params[:id]))
      id = params[:id].to_i
      if id < 8
        @area_id = 2
      elsif id < 15
        @area_id = 3
      elsif id < 24
        @area_id = 4
      elsif id < 31
        @area_id = 5
      elsif id < 36
        @area_id = 6
      elsif id < 40
        @area_id = 7
      else
        @area_id = 8
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :user_id, :start_station, :end_station,
      :start_station_prefecture, :end_station_prefecture, :line_code,
      :body, :time_zone, :spot, :latitude, :longitude,
      post_images: [],
      images_attachments_attributes: [ :id, :_destroy ]
    )
  end
end


