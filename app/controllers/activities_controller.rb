# frozen_string_literal: true

class ActivitiesController < ApplicationController
  include Pagy::Backend

  before_action :set_activity, only: %i[show]
  authorize_resource

  def index
    @pagy, @activities = pagy(Activity.for_user(current_user).order(id: :desc))
  end

  def show
  end

  private
    def set_activity
      @activity = Activity.find(params[:activity_id] || params[:id])
    end
end
