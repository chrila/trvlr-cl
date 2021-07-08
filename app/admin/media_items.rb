# frozen_string_literal: true

ActiveAdmin.register MediaItem do
  permit_params :title, :description, :waypoint_id, :user_id
end
