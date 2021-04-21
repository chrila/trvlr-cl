class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.for_user(current_user).order(:id).reverse
  end

  def show
    @activity = Activity.find(params[:id])
  end
end
