module TripUsersHelper
  def trip_user_roles_list
    TripUser.roles.keys.collect { |r| [r.split('_').last.humanize, r] }
  end
end
