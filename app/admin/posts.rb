ActiveAdmin.register Post do
  permit_params :waypoint_id, :title, :content, :user_id
end
