module TripsHelper
  def participant_list(trip)
    trip.users.map(&:username).join(', ')
  end

  def visibilities_list
    hash = Trip.visibilities
    keys = hash.keys.map { |k| k.split('_').last.humanize }
    [keys, hash.values].transpose.to_h
    Trip.visibilities.keys.collect { |k| [k.split('_').last.humanize, k] }
  end

  def statuses_list
    hash = Trip.statuses
    keys = hash.keys.map { |k| k.split('_').last.humanize }
    [keys, hash.values].transpose.to_h
    Trip.statuses.keys.collect { |k| [k.split('_').last.humanize, k] }
  end
end
