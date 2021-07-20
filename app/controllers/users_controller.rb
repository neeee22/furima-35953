class UsersController < ApplicationController
  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email) # 編集出来る情報を制限
  end

end

