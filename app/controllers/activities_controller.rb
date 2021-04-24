class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show like dislike]
  authorize_resource

  def index
    @activities = Activity.for_user(current_user).order(:id).reverse
  end

  def show
  end

  def like
    Like.like(current_user, @activity)
  end

  def dislike
    Like.dislike(current_user, @activity)
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end
end
