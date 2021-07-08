# frozen_string_literal: true

class ActivitiesController < ApplicationController
  include Pagy::Backend

  before_action :set_activity, only: %i[show like dislike]
  authorize_resource

  def index
    @pagy, @activities = pagy(Activity.for_user(current_user).order(id: :desc))
  end

  def show
  end

  def like
    @activity.like current_user
    set_activity
  end

  def dislike
    @activity.dislike current_user
    set_activity
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end
end
