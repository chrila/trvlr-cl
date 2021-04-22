module TripsHelper
  def participant_list(trip)
    trip.users.map(&:username).join(', ')
  end
end
