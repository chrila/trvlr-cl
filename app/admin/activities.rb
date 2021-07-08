# frozen_string_literal: true

ActiveAdmin.register Activity do
  permit_params :description, :user_id
end
