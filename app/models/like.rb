# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  scope :created_between, ->(date_from, date_to) { where('created_at between ? and ?', date_from, date_to) }
end
