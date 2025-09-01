class Patient < ApplicationRecord
	has_many :appointments, dependent: :destroy
	validates :name, presence: true
	validates :date_of_birth, presence: true

	def age
		return unless date_of_birth
		now = Time.zone.now.to_date
		now.year - date_of_birth.year - ((now.month > date_of_birth.month || (now.month == date_of_birth.month && now.day >= date_of_birth.day)) ? 0 : 1)
	end

	def upcoming_appointments
		appointments.where('scheduled_at > ?', Time.zone.now)
	end

	# Pending: implement full_name
	def full_name
		# TODO: implement full_name
	end

	# Pending: implement with_appointments_today
	def self.with_appointments_today
		# TODO: implement with_appointments_today
	end
end
