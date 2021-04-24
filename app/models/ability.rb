# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :destroy, Comment, user_id: user.id
    end
  end
end
