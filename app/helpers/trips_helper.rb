module TripsHelper
  def participant_list(trip)
    trip.users.map(&:username).join(', ')
  end

  def trip_visibilities_list
    Trip.visibilities.keys.collect { |k| [k.split('_').last.humanize, k] }
  end

  def trip_statuses_list
    Trip.statuses.keys.collect { |k| [k.split('_').last.humanize, k] }
  end

  def role_of_user_in_trip(user, trip)
    trip.trip_users.find_by(user: user).role_string
  end
end
