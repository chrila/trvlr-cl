# frozen_string_literal: true

module TripUsersHelper
  def trip_user_roles_list
    TripUser.roles.keys.collect { |r| [r.split("_").last.humanize, r] }
  end

  def trip_role_bg_class(trip_user)
    bg_classes = {
      role_administrator: "bg-primary",
      role_editor: "bg-success",
      role_participant: "bg-secondary"
    }
    bg_classes[trip_user.role.to_sym]
  end
end
