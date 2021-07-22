# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # visitors can view public trips and their details
    can :read, Trip, visibility: "visibility_public"
    can :index_public, Trip
    cannot :index, Trip

    can :index, TripUser do |t|
      can? :read, t.trip
    end

    can %i[index read], Waypoint do |w|
      can? :read, w.trip
    end
    can %i[index read], Segment do |s|
      can? :read, s.trip
    end
    can %i[index_trip index_waypoint index_public read], Post do |p|
      can? :read, p.trip
    end
    can %i[index_trip index_waypoint index_public read], MediaItem do |m|
      can? :read, m.trip
    end

    return unless user.present?

    # Summary
    # users can see their summary page
    can %i[overall current_year last_year], :summary

    # User profiles
    # users can see other users' profile pages
    can %i[read follow unfollow], User

    # Comments
    # users can read, create, like and dislike comments, but only delete and edit their own comments
    can :manage, Comment, user_id: user.id
    can :read, Comment
    can %i[create like dislike], Comment

    # Likes
    # users can create and destroy likes
    can %i[create destroy], Like

    # Activities
    # users can read, like and dislike all activities
    can %i[read like dislike], Activity

    # Trips
    # users can see and like/dislike trips that are public and users-only
    can %i[read like dislike], Trip, visibility: ["visibility_public", "visibility_users"]
    # private trips can only be read by participants
    can %i[read like dislike], Trip do |t|
      t.visibility_private? && t.user_ids.include?(user.id)
    end
    # users can manage trips which they participate in as administrator
    can :manage, Trip, user.trips do |t|
      t.trip_users.role_administrator.map(&:user).include? user
    end
    # Users that can see the trip can also see a list of comments for the trip
    can :index_trip, Comment do |c|
      can? :read, c.commentable
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
    can %i[manage_mediaitem], Trip do |t|
      t.trip_users.role_administrator.map(&:user).include?(user) ||
        t.trip_users.role_editor.map(&:user).include?(user)
    end
    can %i[manage], MediaItem do |m|
      can? :manage_mediaitem, m.trip
    end

    can %i[manage_post], Trip do |t|
      t.trip_users.role_administrator.map(&:user).include?(user) ||
        t.trip_users.role_editor.map(&:user).include?(user)
    end
    can %i[manage], Post do |p|
      can? :manage_post, p.trip
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
