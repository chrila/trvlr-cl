# frozen_string_literal: true

class Activities::LikesController < ApplicationController
  include LikeableController

  before_action :set_likeable

  private
    def set_likeable
      @likeable = Activity.find(params[:activity_id])
    end
end
