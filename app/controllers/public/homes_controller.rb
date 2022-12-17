class Public::HomesController < ApplicationController
  def top
    # ブックマーク数順
    # 同じpost_idのbookmarkをグループ化、bookmark_idの多い順に並び替え、上位6件のpost_idを取り出す
    @popular_posts = Post.find(Bookmark.group(:post_id).order('count(id) desc').limit(6).pluck(:post_id))
    # 新着順
    @new_posts = Post.order('id desc').limit(6)
  end
end
