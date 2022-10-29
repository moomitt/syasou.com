class Admin::UsersController < ApplicationController
  def index
    @all_users = User.all
  end

  def show
    @user = User.find(params[:id])
    @followings = @user.followings
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:id])
    @all_users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @all_users = @user.followers
  end

  def posts
    @user = User.find(params[:id])
    all_posts = Post.where(user_id: @user.id)
    @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
    @new_posts = all_posts.order('id desc')
  end

  def edit
    @user = User.find(params[:id])
  end

  def image_destroy
    @user = User.find(params[:id])
    if @user.user_image.purge
      redirect_to edit_admin_user_path(@user.id)
    else
      render :edit
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
