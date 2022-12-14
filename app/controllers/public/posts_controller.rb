class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def detail
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    if params[post_images: []]       # 画像アップロード時に圧縮
      params[post_images: []].each do |image|
        image.tempfile = ImageProcessing::MiniMagick
                         .source(image.tempfile).resize_to_limit(600, 600).call
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
    session[:previous_url] = request.referer # 前ページセッションを保存
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
    if params[post_images: []] # 画像アップロード時に圧縮
      params[post_images: []].each do |image|
        image.tempfile = ImageProcessing::MiniMagick
                         .source(image.tempfile).resize_to_limit(600, 600).call
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
      if session[:previous_url].match(/detail/)    # detailページに戻るとエラーになるため、newページにリダイレクトさせる
        redirect_to new_post_path                  #
      elsif session[:previous_url].match(/edit/)   # editページに戻るとエラーになる
        redirect_to users_posts_path               # あなたの投稿ページにリダイレクトさせる
      else
        redirect_to session[:previous_url]         # showページの1つ前のページにリダイレクト
      end
    else
      @post.destroy
      if session[:previous_url].match(/detail/)    # detailページに戻るとエラーになる
        redirect_to new_post_path                  # \newページにリダイレクトさせる
      elsif session[:previous_url].match(/edit/)   # editページに戻るとエラーになる
        redirect_to users_posts_path               # あなたの投稿ページにリダイレクトさせる
      else
        redirect_to session[:previous_url]         # showページの1つ前のページにリダイレクト
      end
    end
  end

  def index
    @all_posts = Post.all
    @map_posts = []
    @all_posts.each do |post|
      hash = { 'post_id' => post.id, 'post_body' => post.body,
               'start_station' => post.start_station, 'end_station' => post.end_station,
               'line_code' => post.line_code,
               'latitude' => post.latitude.to_s, 'longitude' => post.longitude.to_s,
               'uniqueness' => 1 }
      hash['post_image'] = if post.post_images.attached?
                             url_for(post.post_images[0].variant(resize_to_fill: [150, 100]))
                           else
                             'no_image'
                           end
      uniqueness = @map_posts.select { |hash| hash['start_station'] == post.start_station }
      hash['uniqueness'] = 1 + uniqueness.length if uniqueness.present?
      @map_posts.push(hash)
    end
  end

  def search_user
    @user = User.find(params[:id])
    if current_user.id == @user.id
      redirect_to users_mypage_path
    else
      posts = Post.where(user_id: @user.id)
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
  end

  def search_area
    if params[:id] == '1'
      @area_name = '北海道'
      posts = Post.where(start_station_prefecture: 1)
                  .or(Post.where(end_station_prefecture: 1))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '2'
      @area_name = '東北'
      ids = [2, 3, 4, 5, 6, 7]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 2..7)
                  .or(Post.where(end_station_prefecture: 2..7))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '3'
      @area_name = '関東'
      ids = [8, 9, 10, 11, 12, 13, 14]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 8..14)
                  .or(Post.where(end_station_prefecture: 8..14))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '4'
      @area_name = '中央・北陸・東海'
      ids = [15, 16, 17, 18, 19, 20, 21, 22, 23]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 15..23)
                  .or(Post.where(end_station_prefecture: 15..23))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '5'
      @area_name = '近畿'
      ids = [24, 25, 26, 27, 28, 29, 30]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 24..30)
                  .or(Post.where(end_station_prefecture: 24..30))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '6'
      @area_name = '中国'
      ids = [31, 32, 33, 34, 35]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 31..35)
                  .or(Post.where(end_station_prefecture: 31..35))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    if params[:id] == '7'
      @area_name = '四国'
      ids = [36, 37, 38, 39]
      @prefectures = Prefecture.find(ids)
      posts = Post.where(start_station_prefecture: 36..39)
                  .or(Post.where(end_station_prefecture: 36..39))
      @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
      @new_posts = posts.order('id desc')
    end
    return unless params[:id] == '8'

    @area_name = '九州・沖縄'
    ids = [40, 41, 42, 43, 44, 45, 46, 47]
    @prefectures = Prefecture.find(ids)
    posts = Post.where(start_station_prefecture: 40..47)
                .or(Post.where(end_station_prefecture: 40..47))
    @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
    @new_posts = posts.order('id desc')
  end

  def search_prefecture
    return unless params[:id]

    @prefecture = Prefecture.find(params[:id])
    posts = Post.where(start_station_prefecture: params[:id])
                .or(Post.where(end_station_prefecture: params[:id]))
    @popular_posts = posts.sort { |a, b| b.bookmarks.size <=> a.bookmarks.size }
    @new_posts = posts.order('id desc')
    id = params[:id].to_i
    @area_id = if id < 8
                 2
               elsif id < 15
                 3
               elsif id < 24
                 4
               elsif id < 31
                 5
               elsif id < 36
                 6
               elsif id < 40
                 7
               else
                 8
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
      images_attachments_attributes: %i[id _destroy]
    )
  end
end
