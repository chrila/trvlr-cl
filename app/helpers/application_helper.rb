module ApplicationHelper
  def beautiful_classname(klass)
    klass.class.to_s.underscore.gsub('_', ' ')
  end
end
