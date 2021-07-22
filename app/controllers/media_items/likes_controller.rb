# frozen_string_literal: true

class MediaItems::LikesController < ApplicationController
  include LikeableController

  before_action :set_likeable

  private
    def set_likeable
      @likeable = MediaItem.find(params[:media_item_id])
    end
end
