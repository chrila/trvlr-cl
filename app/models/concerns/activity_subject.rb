# frozen_string_literal: true

module ActivitySubject
  extend ActiveSupport::Concern

  def owned_by?(a_user)
    user == a_user
  end
end
