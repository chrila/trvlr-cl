class TripUser < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  enum role: %i[role_participant role_editor role_administrator]

  validates :user, presence: true
  validates :role, presence: true, inclusion: { in: TripUser.roles, message: 'is invalid' }

  def role_string
    role.split('_').last.humanize
  end
end
