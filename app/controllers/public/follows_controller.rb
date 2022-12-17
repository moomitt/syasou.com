class Public::FollowsController < ApplicationController
  # 非同期処理
  def create
    @user = User.find(params[:user_id])
    following = current_user.follow(@user)
    following.save
  end

  
  def destroy
    @user = User.find(params[:user_id])
    following = current_user.unfollow(@user)
    following.destroy
  end
end
