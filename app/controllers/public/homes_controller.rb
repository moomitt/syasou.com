class Public::HomesController < ApplicationController
  def top
    @pupular_posts = Post.left_joins(:bookmarks).group(:id).order('count(bookmarks.post_id) desc').limit(3)
    @new_posts = Post.order('id desc').limit(6)
  end
end
