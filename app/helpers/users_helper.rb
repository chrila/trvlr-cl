# frozen_string_literal: true

module UsersHelper
  def user_list
    User.all.collect { |u| [u, u.id] }
  end
end
