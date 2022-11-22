class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @followings = @user.followings
    @followers = @user.followers
  end

  def followings
    @user = current_user
    @followings = @user.followings.page(params[:page]).per(10)
  end

  def followers
    @user = current_user
    @followers = @user.followers.page(params[:page]).per(1)
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
      params[:user_image].tempfile = ImageProcessing::MiniMagick
      .source(params[:user_image].tempfile).resize_to_limit(600, 600).call
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
    posts = Post.where(user_id: @user.id)
    all_popular_posts = posts.sort{|a,b| b.bookmarks.size <=> a.bookmarks.size}
    @popular_posts = Kaminari.paginate_array(all_popular_posts).page(params[:page]).per(4)
    @new_posts = posts.order('id desc').page(params[:page]).per(4)
  end

  def bookmarks
    @user = current_user
    @bookmarks = Bookmark.where(user_id: @user.id).page(params[:page]).per(4)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
