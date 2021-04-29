module TripUsersHelper
  def trip_user_roles_list
    TripUser.roles.keys.collect { |r| [r.split('_').last.humanize, r] }
  end

  def bg_class_for_role(trip_user)
    badge_classes = {
      role_administrator: 'bg-primary',
      role_editor: 'bg-success',
      role_participant: 'bg-secondary'
    }
    badge_classes[trip_user.role.to_sym]
  end
end
