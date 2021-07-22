# frozen_string_literal: true

class Comments::LikesController < ApplicationController
  include LikeableController

  before_action :set_likeable

  private
    def set_likeable
      @likeable = Comment.find(params[:comment_id])
    end
end
