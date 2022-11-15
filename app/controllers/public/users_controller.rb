class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @followings = @user.followings
    @followers = @user.followers
  end

  def followings
    @user = current_user
    @all_users = @user.followings
  end

  def followers
    @user = current_user
    @all_users = @user.followers
  end

  def edit
    @user = current_user
  end

  def image_destroy
    @user = current_user
    if @user.user_image.purge
      redirect_to users_information_edit_path
    else
      render :edit
    end
  end

  def update
    @user = current_user
    if params[:user_image]       #画像アップロード時に圧縮
      params[:user_image].tempfile = ImageProcessing::MiniMagick.source(params[:user_image].tempfile).resize_to_limit(00, 600).call
    end
    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render :edit
    end
  end

  def confirm
    @user = current_user
  end

  def withdraw
    user = current_user
    Follow.where(user_id: user.id).destroy_all
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def posts
    @user = current_user
    all_posts = Post.where(user_id: @user.id)
    @popular_posts = all_posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
    @new_posts = all_posts.order('id desc')
  end

  def bookmarks
    @user = current_user
    @all_bookmarks = Bookmark.where(user_id: @user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
