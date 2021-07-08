# frozen_string_literal: true

ActiveAdmin.register Segment do
  permit_params :trip_id, :waypoint_from_id, :waypoint_to_id, :time_from, :time_to, :distance, :status
end
