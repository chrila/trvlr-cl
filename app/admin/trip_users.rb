# frozen_string_literal: true

ActiveAdmin.register TripUser do
  permit_params :role, :user_id, :trip_id
end
