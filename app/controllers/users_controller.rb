class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
