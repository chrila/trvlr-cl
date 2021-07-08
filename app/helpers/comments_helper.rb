# frozen_string_literal: true

module CommentsHelper
  def new_comment_path(commentable)
    send("#{commentable.class.to_s.underscore}_new_comment_path")
  end
end
