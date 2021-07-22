# frozen_string_literal: true

class Trips::CommentsController < ApplicationController
  include CommentableController

  before_action :set_commentable

  private
    def set_commentable
      @commentable = Trip.find(params[:trip_id])
    end
end
