class Appointment < ApplicationRecord
  belongs_to :patient
  validates :scheduled_at, presence: true
  validates :reason, presence: true
  # Pending: implement description
  def description
    # TODO: implement description
  end
end
