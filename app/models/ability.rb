# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # visitors can view public trips
    can :read, Trip, visibility: :visibility_public

    return unless user.present?

    # Comments
    # users can read all comments, but only delete their own comments
    can :destroy, Comment, user_id: user.id
    can :read, Comment

    # Activities
    # users can read all activities
    can :read, Activity
    can :like, :activity
    can :dislike, :activity

    # Trips
    # users can see trips that are set to 'visibility_users'
    can :read, Trip, visibility: :visibility_users
    # private trips can only be read by participants
    can :read, Trip do |t|
      t.visibility == :visibility_private && user_ids.include?(user.id)
    end
    # users can manage trips which they participate in as administrator
    can :manage, Trip, user.trips do |t|
      t.trip_users.role_administrator.map(&:user).include? user
    end
  end
end
