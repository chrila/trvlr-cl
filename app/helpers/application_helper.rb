module ApplicationHelper
  include Pagy::Frontend

  def beautify_classname(klass)
    klass.class.to_s.underscore.gsub('_', ' ')
  end
end
