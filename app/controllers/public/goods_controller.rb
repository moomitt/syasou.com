class Public::GoodsController < ApplicationController
  # 非同期処理
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    good = current_user.goods.new(comment_id: @comment.id)
    good.save
  end

  # 非同期処理
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    good = current_user.goods.find_by(comment_id: @comment.id)
    good.destroy
  end
end
