class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def detail
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    if params[post_images: []]       #画像アップロード時に圧縮
      params[post_images: []].each do |image|
        image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_limit(600, 600).call
      end
    end
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
    session[:previous_url] = request.referer     #前ページセッションを保存
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
    if params[post_images: []]       #画像アップロード時に圧縮
      params[post_images: []].each do |image|
        image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_limit(200, 200).call
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
    if @post.post_images.attached?
      @post.post_images.purge_later && @post.destroy
      if session[:previous_url].match(/detail/)  #detailページに戻るとエラーになるため、
        redirect_to new_post_path                #エラー回避のため、newページにリダイレクトさせる
      else
        redirect_to session[:previous_url]       #showページの1つ前のページにリダイレクト
      end
    else
      @post.destroy
      if session[:previous_url].match(/detail/)  #detailページに戻るとエラーになるため、
        redirect_to new_post_path                #エラー回避のため、newページにリダイレクトさせる
      else
        redirect_to session[:previous_url]       #showページの1つ前のページにリダイレクト
      end
    end
  end

  def index
    @all_posts = Post.all
    @map_posts = Array::new
    @all_posts.each do |post|
      hash = {"post_id" => post.id, "post_body" => post.body,
      "start_station" => post.start_station, "end_station" => post.end_station,
      "line_code" => post.line_code,
      "latitude" => post.latitude.to_s, "longitude" => post.longitude.to_s,
      "uniqueness" => 1 }
      if post.post_images.attached?
        hash["post_image"] = url_for(post.post_images[0].variant(resize_to_fill: [150, 100]))
      else
        hash["post_image"] = '/assets/no_image.png'
      end
      uniqueness = @map_posts.select{|hash| hash["start_station"] == post.start_station }
      if uniqueness.present?
        hash["uniqueness"] = 1 + uniqueness.length
      end
      @map_posts.push(hash)
    end
  end

  def search_user
    @user = User.find(params[:id])
    if current_user.id == @user.id
      redirect_to users_mypage_path
    else
      all_posts = Post.where(user_id: @user.id)
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
  end

  def search_area
    if params[:id] == "1"
      @area_name = "北海道"
      all_posts = Post.where(start_station_prefecture: 1)
      .or(Post.where(end_station_prefecture: 1))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "2"
      @area_name = "東北"
      ids = [2, 3, 4, 5, 6, 7]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 2..7)
      .or(Post.where(end_station_prefecture: 2..7))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "3"
      @area_name = "関東"
      ids = [8, 9, 10, 11, 12, 13, 14]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 8..14)
      .or(Post.where(end_station_prefecture: 8..14))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "4"
      @area_name = "中央・北陸・東海"
      ids = [15, 16, 17, 18, 19, 20, 21, 22, 23]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 15..23)
      .or(Post.where(end_station_prefecture: 15..23))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "5"
      @area_name = "近畿"
      ids = [24, 25, 26, 27, 28, 29, 30]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 24..30)
      .or(Post.where(end_station_prefecture: 24..30))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "6"
      @area_name = "中国"
      ids = [31, 32, 33, 34, 35]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 31..35)
      .or(Post.where(end_station_prefecture: 31..35))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "7"
      @area_name = "四国"
      ids = [36, 37, 38, 39]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 36..39)
      .or(Post.where(end_station_prefecture: 36..39))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
    if params[:id] == "8"
      @area_name = "九州・沖縄"
      ids = [40, 41, 42, 43, 44, 45, 46, 47]
      @prefectures = Prefecture.find(ids)
      all_posts = Post.where(start_station_prefecture: 40..47)
      .or(Post.where(end_station_prefecture: 40..47))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
    end
  end

  def search_prefecture
    if params[:id]
      @prefecture = Prefecture.find(params[:id])
      all_posts = Post.where(start_station_prefecture: params[:id])
      .or(Post.where(end_station_prefecture: params[:id]))
      @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
      @new_posts = all_posts.order('id desc')
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
      :user_id, :start_station, :end_station, :line_code,
      :start_station_name, :end_station_name, :line_name,
      :start_station_prefecture, :end_station_prefecture,
      :body, :time_zone, :spot, :latitude, :longitude,
      post_images: [],
      images_attachments_attributes: [ :id, :_destroy ]
    )
  end
end


