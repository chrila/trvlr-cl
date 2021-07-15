# frozen_string_literal: true

class MediaItems::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable

  private
    def set_commentable
      @commentable = MediaItem.find(params[:media_item_id])
    end
end
