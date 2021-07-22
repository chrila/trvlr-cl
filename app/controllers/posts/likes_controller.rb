# frozen_string_literal: true

class Posts::LikesController < ApplicationController
  include LikeableController

  before_action :set_likeable

  private
    def set_likeable
      @likeable = Post.find(params[:post_id])
    end
end
