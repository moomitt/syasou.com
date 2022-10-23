class Public::UsersController < ApplicationController
  def show
    @user = current_user
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
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :user_image)
  end
end
