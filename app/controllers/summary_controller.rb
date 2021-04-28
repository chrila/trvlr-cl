class SummaryController < ApplicationController
  authorize_resource class: false

  def overall
    @stats = calculate_stats(Date.new, Time.now)
    @stats[:title] = 'Overall'
    render :stats_overall
  end

  def current_year
    @stats = calculate_stats(Time.now.beginning_of_year, Time.now)
    @stats[:title] = 'Current year'
    render :stats_year
  end

  def last_year
    @stats = calculate_stats(Time.now.beginning_of_year - 1.year, Time.now.beginning_of_year)
    @stats[:title] = 'Last year'
    render :stats_year
  end

  private

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
    stats[:waypoints_per_continent] = calculate_waypoints_per_continent(segments)
    stats[:distance_per_year] = calculate_distance_per_year(segments)
    stats[:distance_per_month] = calculate_distance_per_month(segments)
    stats
  end

  def calculate_countries(segments)
    (segments.joins(:waypoint_from).pluck(:country) + segments.joins(:waypoint_to).pluck(:country)).uniq.count
  end

  def get_continents(segments)
    (segments.joins(:waypoint_from).pluck(:continent) + segments.joins(:waypoint_to).pluck(:continent))
  end

  def calculate_continents(segments)
    get_continents(segments).uniq.count
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

  def to_data_row_count(arr)
    arr.group_by { |x| x }.map { |x, y| [x, y.count] }.to_h.sort
  end

  def to_data_row_sum(arr)
    arr.group_by(&:first).map { |x, y| [x, y.inject(0) { |sum, i| sum + i.last }] }.to_h.sort
  end

  def calculate_waypoints_per_continent(segments)
    to_data_row_count get_continents(segments)
  end

  def dummy_data(from, to)
    arr = []
    (from..to).each do |i|
      arr << [i + 1, 0]
    end
    arr
  end

  def get_distance_and_month(segments)
    segments.pluck(:time_to, :distance).map { |time, distance| [time.month, distance] } + dummy_data(1, 12)
  end

  def calculate_distance_per_month(segments)
    to_data_row_sum get_distance_and_month(segments)
  end

  def get_distance_and_year(segments)
    segments.pluck(:time_to, :distance).map { |time, distance| [time.year, distance] } +
      dummy_data(segments.pluck(:time_to).min.year, segments.pluck(:time_to).max.year)
  end

  def calculate_distance_per_year(segments)
    to_data_row_sum get_distance_and_year(segments)
  end
end
