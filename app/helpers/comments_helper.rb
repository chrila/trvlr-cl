module CommentsHelper
  def new_comment_path(commentable)
    send("#{commentable.class.to_s.downcase}_new_comment_path")
  end
end
