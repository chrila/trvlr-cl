# frozen_string_literal: true

class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_comment, only: %i[edit update destroy like dislike]
  authorize_resource

  def edit
  end

  def create
    @comment = Comment.create(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        Activity.create(user: current_user, subject: @comment.commentable, action: "commented on")
        format.html { redirect_to polymorphic_path(@comment.commentable, anchor: dom_id(@comment)), notice: "Comment was successfully created." }
      else
        format.html { redirect_back fallback_location: @comment.commentable, alert: error_string("create") }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to polymorphic_path(@comment.commentable, anchor: dom_id(@comment)), notice: "Comment was successfully updated." }
      else
        format.html { redirect_back fallback_location: @comment.commentable, alert: error_string("update") }
      end
    end
  end

  def destroy
    commentable = @comment.commentable
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to commentable, notice: "Comment was successfully deleted." }
      else
        format.html { redirect_to commentable, alert: "Comment could not be deleted." }
      end
    end
  end

  def like
    @comment.like current_user
    set_comment
  end

  def dislike
    @comment.dislike current_user
    set_comment
  end

  private
    def comment_params
      params.require(:comment).permit(%i[content commentable_type commentable_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def error_string(action)
      "Could not #{action} comment. Errors:<ul><li>#{@comment.errors.full_messages.join('<li>')}</ul>"
    end
end
