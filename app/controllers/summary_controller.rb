class SummaryController < ApplicationController
  authorize_resource class: false
  before_action :init_stats

  def overall
    @stats = calculate_stats(Date.new, Time.now)
    @stats[:title] = 'Overall'
    render :show
  end

  def current_year
    @stats = calculate_stats(Time.now.beginning_of_year, Time.now)
    @stats[:title] = 'Current year'
    render :show
  end

  private

  def init_stats
    @stats = {
      countries: 0,
      continents: 0,
      km: 0,
      pictures: 0,
      posts: 0,
      likes: 0,
      comments: 0
    }
  end

  def calculate_stats(date_from, date_to)
    segments = current_user.segments.finished_between(date_from, date_to)
    stats = {}
    stats[:countries] = calculate_countries(segments)
    stats[:continents] = calculate_continents(segments)
    stats[:km] = calculate_km(segments)
    stats[:pictures] = calculate_pictures(current_user.media_items.created_between(date_from, date_to))
    stats[:posts] = calculate_posts(current_user.posts.created_between(date_from, date_to))
    stats[:likes] = calculate_likes(date_from, date_to)
    stats[:comments] = calculate_comments(date_from, date_to)
    stats
  end

  def calculate_countries(segments)
    segments.joins(:waypoint_from).pluck(:country).uniq.count
  end

  def calculate_continents(segments)
    segments.joins(:waypoint_from).pluck(:continent).uniq.count
  end

  def calculate_km(segments)
    segments.map(&:distance).sum.round(2)
  end

  def calculate_pictures(media_items)
    media_items.count
  end

  def calculate_posts(posts)
    posts.count
  end

  def calculate_likes(date_from, date_to)
    Like.created_between(date_from, date_to).where(likeable: current_user.trips).count +
    Like.created_between(date_from, date_to).where(likeable: current_user.posts).count +
    Like.created_between(date_from, date_to).where(likeable: current_user.media_items).count +
    Like.created_between(date_from, date_to).where(likeable: current_user.activities).count
  end

  def calculate_comments(date_from, date_to)
    Comment.created_between(date_from, date_to).where(commentable: current_user.trips).count +
    Comment.created_between(date_from, date_to).where(commentable: current_user.posts).count +
    Comment.created_between(date_from, date_to).where(commentable: current_user.media_items).count
  end
end
