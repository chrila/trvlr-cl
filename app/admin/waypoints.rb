ActiveAdmin.register Waypoint do
  permit_params :trip_id, :name, :notes, :address, :country, :continent, :longitude, :latitude
end
