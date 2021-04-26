class SummaryController < ApplicationController
  authorize_resource class: false
  before_action :init_stats

  def index
    calculate_stats_total
  end

  private

  def init_stats
    @stats_total = {
      countries: 0,
      continents: 0,
      km: 0,
      pictures: 0,
      posts: 0,
      likes: 0,
      comments: 0
    }
  end

  def calculate_stats_total
    @stats_total[:countries] = current_user.waypoints.pluck(:country).uniq.count
    @stats_total[:continents] = current_user.waypoints.pluck(:continent).uniq.count
    @stats_total[:km] = current_user.segments.where(status: 'segment_finished').map(&:distance).sum.round(2)
    @stats_total[:pictures] = current_user.media_items.count
    @stats_total[:posts] = current_user.posts.count
    @stats_total[:likes] = calc_likes_received_total
    @stats_total[:comments] = calc_comments_received_total
  end

  def calc_likes_received_total
    current_user.trips.map(&:likes_count).sum +
      current_user.posts.map(&:likes_count).sum +
      current_user.media_items.map(&:likes_count).sum +
      current_user.activities.map(&:likes_count).sum
  end

  def calc_comments_received_total
    current_user.trips.map(&:comments_count).sum +
      current_user.posts.map(&:comments_count).sum +
      current_user.media_items.map(&:comments_count).sum
  end
end
