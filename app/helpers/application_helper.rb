module ApplicationHelper
  include Pagy::Frontend

  def beautify_classname(klass)
    klass.class.to_s.underscore.gsub('_', ' ')
  end

  def truncate_string(str, len = 30)
    str.length > len ? "#{str[0, len]}..." : str
  end

  def like_path(likeable)
    send("#{likeable.class.to_s.underscore}_like_path", likeable)
  end

  def dislike_path(likeable)
    send("#{likeable.class.to_s.underscore}_dislike_path", likeable)
  end

  def comments_path(commentable)
    "#{url_for(commentable)}#comments"
  end
end
