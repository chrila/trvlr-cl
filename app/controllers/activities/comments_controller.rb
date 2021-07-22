# frozen_string_literal: true

class Activities::CommentsController < ApplicationController
  include CommentableController

  before_action :set_commentable

  private
    def set_commentable
      @commentable = Activity.find(params[:activity_id])
    end
end
