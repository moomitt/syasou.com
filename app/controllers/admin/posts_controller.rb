class Admin::PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = Comment.where(post_id: @post.id)
    session[:previous_url] = request.referer     #前ページセッションを保存
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.post_images.attached?
      @post.post_images.purge_later && @post.destroy
      redirect_to session[:previous_url]
    else
      @post.destroy
      redirect_to session[:previous_url]    #2つ前のページにリダイレクト
    end
  end
end
