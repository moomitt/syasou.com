class Public::BookmarksController < ApplicationController
  # 非同期処理
  def create
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: @post.id)
    bookmark.save
  end

  # 非同期処理
  def destroy
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy
  end
end
