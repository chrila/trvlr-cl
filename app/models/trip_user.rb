class TripUser < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  enum role: %i[role_participant role_editor role_administrator]

  def role_string
    role.split('_').last.humanize
  end
end
