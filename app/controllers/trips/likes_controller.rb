# frozen_string_literal: true

class Trips::LikesController < ApplicationController
  include LikeableController

  before_action :set_likeable

  private
    def set_likeable
      @likeable = Trip.find(params[:trip_id])
    end
end
