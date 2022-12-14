class Admin::PostsController < ApplicationController
  def index
    @all_posts = Post.all
    @map_posts = []
    @all_posts.each do |post|
      hash = { 'post_id' => post.id, 'post_body' => post.body,
               'start_station' => post.start_station, 'end_station' => post.end_station,
               'line_code' => post.line_code,
               'latitude' => post.latitude, 'longitude' => post.longitude }
      hash['post_image'] = if post.post_images.attached?
                             url_for(post.post_images[0].variant(resize_to_fill: [150, 100]))
                           else
                             'no_image'
                           end
      @map_posts.push(hash)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = Comment.where(post_id: @post.id)
    session[:previous_url] = request.referer     # 前ページセッションを保存
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.post_images.attached?
      @post.post_images.purge_later && @post.destroy
      redirect_to session[:previous_url]
    else
      @post.destroy
      redirect_to session[:previous_url]    # 2つ前のページにリダイレクト
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
end
