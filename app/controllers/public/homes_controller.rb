class Public::HomesController < ApplicationController
  def top
    @popular_posts = Post.find(Bookmark.group(:post_id).order('count(id) desc').limit(6).pluck(:post_id))
    @new_posts = Post.order('id desc').limit(6)
  end

  #Bookmarkモデルのpost_idが同じものでまとめて
  #それをbookmark_idの多い順に並び替えて、post_idで取り出す
end
