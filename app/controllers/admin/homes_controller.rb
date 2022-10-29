class Admin::HomesController < ApplicationController
  def top
    @popular_posts = Post.find(Bookmark.group(:post_id).order('count(id) desc').limit(6).pluck(:post_id))
    @new_posts = Post.order('id desc').limit(6)
  end
end
