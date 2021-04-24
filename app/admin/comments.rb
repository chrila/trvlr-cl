ActiveAdmin.register Comment do
  permit_params :title, :content, :user_id, :commentable_type, :commentable_id
end
