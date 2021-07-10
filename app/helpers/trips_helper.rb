# frozen_string_literal: true

module TripsHelper
  def participant_list(trip)
    trip.users.map(&:username).join(", ")
  end

  def trip_visibilities_list
    Trip.visibilities.keys.collect { |k| [k.split("_").last.humanize, k] }
  end

  def trip_statuses_list
    Trip.statuses.keys.collect { |k| [k.split("_").last.humanize, k] }
  end

  def user_in_trip(user, trip)
    trip.trip_users.find_by(user: user)
  end

  def trip_status_bg_class(trip)
    bg_classes = {
      trip_draft: "bg-secondary",
      trip_active: "bg-warning text-dark",
      trip_finished: "bg-success",
      trip_cancelled: "bg-danger"
    }
    bg_classes[trip.status.to_sym]
  end
end
