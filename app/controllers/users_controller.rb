# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def follow
    current_user.follow(@user)
    redirect_to root_path
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
