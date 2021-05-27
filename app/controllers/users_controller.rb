class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.order(" id DESC ").page(params[:page]).per(9)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user.id), success: '登録情報を編集しました'
    else
      flash.now[:danger] = '登録情報の編集ができませんでした'
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to root_path, success: 'アカウントを削除しました'
    else
      flash.now[:danger] = 'アカウントの削除ができませんでした'
      render :show
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end


  private

  def user_params
    params.require(:user).permit(:image, :user_name, :introduction)
    # params.require(:user).permit(:user_name, :introduction)
  end

end
