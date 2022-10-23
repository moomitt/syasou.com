class Public::GoodsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    good = current_user.goods.new(comment_id: @comment.id)
    good.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    good = current_user.goods.find_by(comment_id: @comment.id)
    good.destroy
  end
end
