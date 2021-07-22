# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  include CommentableController

  before_action :set_commentable

  private
    def set_commentable
      @commentable = Post.find(params[:post_id])
    end
end
