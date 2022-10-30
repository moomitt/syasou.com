class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(comment_params)
    @new_comment.post_id = @post.id
    if @new_comment.save
      redirect_to post_path(@post.id, anchor: 'comment-form')
    else
      @user = @post.user
      @comments = Comment.where(post_id: @post.id)
      render "public/posts/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = Post.find(comment.post_id)
    comment.destroy
    redirect_to post_path(post.id, anchor: 'comment-form')
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
