ActiveAdmin.register Trip do
  permit_params :title, :description, :start_date, :end_date, :budget, :visibility, :status
end
