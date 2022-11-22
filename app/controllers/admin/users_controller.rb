class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @followings = @user.followings
    @followers = @user.followers
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(10)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(10)
  end

  def posts
    @user = User.find(params[:id])
    posts = Post.where(user_id: @user.id)
    all_popular_posts = posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
    @popular_posts = Kaminari.paginate_array(all_popular_posts).page(params[:page]).per(4)
    @new_posts = posts.order('id desc').page(params[:page]).per(4)
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
    params.require(:user).permit(:name, :email, :user_image, :is_deleted)
  end
end
