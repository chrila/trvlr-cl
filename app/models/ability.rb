# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # visitors can view public trips and their details
    can :read, Trip, visibility: 'visibility_public'
    cannot :index, Trip

    can :index, TripUser do |t|
      can? :read, t.trip
    end

    can :index, Waypoint do |w|
      can? :read, w.trip
    end
    can :index, Segment do |s|
      can? :read, s.trip
    end
    can %i[index_trip index_waypoint], Post do |p|
      can? :read, p.trip
    end
    can %i[index_trip index_waypoint], MediaItem do |m|
      can? :read, m.trip
    end

    return unless user.present?

    # Summary
    # users can see their summary page
    can %i[overall current_year], :summary

    # User profiles
    # users can see other users' profile pages
    can %i[read follow unfollow], User

    # Comments
    # users can read, create, like and dislike comments, but only delete their own comments
    can :destroy, Comment, user_id: user.id
    can :read, Comment
    can %i[new_activity new_media_item new_post new_trip create like dislike], Comment

    # Activities
    # users can read, like and dislike all activities
    can %i[read like dislike], Activity

    # Trips
    # users can see and like/dislike trips that are public and users-only
    can %i[read like dislike], Trip, visibility: ['visibility_public', 'visibility_users']
    # private trips can only be read by participants
    can %i[read like dislike], Trip do |t|
      t.visibility_private? && t.user_ids.include?(user.id)
    end
    # users can manage trips which they participate in as administrator
    can :manage, Trip, user.trips do |t|
      t.trip_users.role_administrator.map(&:user).include? user
    end

    # Participants
    # only users that can manage a trip can also manage participants
    can :manage, TripUser do |t|
      can? :manage, t.trip
    end

    # Waypoints and segments
    # They can only be managed by the administrator of the trip
    can :manage, Waypoint do |w|
      can? :manage, w.trip
    end
    can :manage, Segment do |s|
      can? :manage, s.trip
    end

    # Media items and posts
    # They can only be created if a user is participating in a trip as 'administrator' or 'editor'
    can %i[new_trip new_waypoint create], MediaItem do |m|
      m.trip.trip_users.role_administrator.map(&:user).include?(user) ||
        m.trip.trip_users.role_editor.map(&:user).include?(user)
    end
    can %i[new_trip new_waypoint create], Post do |p|
      p.trip.trip_users.role_administrator.map(&:user).include?(user) ||
        p.trip.trip_users.role_editor.map(&:user).include?(user)
    end
    # Reading is analog to the trip's permission
    can %i[read like dislike], MediaItem do |m|
      can? :read, m.trip
    end
    can %i[read like dislike], Post do |p|
      can? :read, p.trip
    end
  end
end
