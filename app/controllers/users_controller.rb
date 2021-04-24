class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def follow
    current_user.follow(@user)
    redirect_to @user
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
