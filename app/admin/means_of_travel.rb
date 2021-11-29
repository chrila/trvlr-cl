# frozen_string_literal: true

ActiveAdmin.register MeansOfTravel do
  permit_params :name, :icon
end
