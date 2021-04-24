# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # visitors can view public trips and their details
    can :read, Trip, visibility: :visibility_public
    cannot :index, Trip

    can :index, Waypoint do |w|
      w.trip.visibility_public?
    end
    can :index, Segment do |s|
      s.trip.visibility_public?
    end
    can %i[index_trip index_waypoint], Post do |p|
      p.trip.visibility_public?
    end
    can %i[index_trip index_waypoint], MediaItem do |m|
      m.trip.visibility_public?
    end

    return unless user.present?

    # Summary
    # users can see their summary page
    can :read, :summary

    # User profiles
    # users can see other users' profile pages
    can :read, User

    # Comments
    # users can read, create, like and dislike comments, but only delete their own comments
    can :destroy, Comment, user_id: user.id
    can :read, Comment
    can %i[new_activity new_media_item new_post new_trip create like dislike], Comment

    # Activities
    # users can read, like and dislike all activities
    can %i[read like dislike], Activity

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
