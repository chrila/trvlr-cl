# frozen_string_literal: true

module CommentableController
  extend ActiveSupport::Concern

  included do
    authorize_resource
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable }
      else
        format.html { redirect_to @commentable }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
