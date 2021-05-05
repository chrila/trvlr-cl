module ApplicationHelper
  include Pagy::Frontend

  def beautify_classname(klass)
    klass.class.to_s.underscore.gsub('_', ' ')
  end

  def truncate_string(str, len = 30)
    str.length > len ? "#{str[0, len]}..." : str
  end
end
