require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:patient) { Patient.create!(name: 'Jane Doe', date_of_birth: '1990-01-01') }

  it 'is valid with valid attributes' do
    appointment = Appointment.new(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect(appointment).to be_valid
  end

  it 'is invalid without a scheduled_at' do
    appointment = Appointment.new(patient: patient, scheduled_at: nil, reason: 'Checkup')
    expect(appointment).not_to be_valid
  end

  it 'is invalid without a reason' do
    appointment = Appointment.new(patient: patient, scheduled_at: 1.day.from_now, reason: nil)
    expect(appointment).not_to be_valid
  end

  it 'is invalid without a patient' do
    appointment = Appointment.new(patient: nil, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect(appointment).not_to be_valid
  end

  it 'belongs to a patient' do
    appointment = Appointment.create!(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect(appointment.patient).to eq(patient)
  end

  it 'can be scheduled in the future' do
    appointment = Appointment.new(patient: patient, scheduled_at: 1.week.from_now, reason: 'Consultation')
    expect(appointment).to be_valid
  end

  it 'can be scheduled in the past' do
    appointment = Appointment.new(patient: patient, scheduled_at: 1.week.ago, reason: 'Follow-up')
    expect(appointment).to be_valid
  end

  it 'returns a formatted description (pending)' do
    pending('Implement Appointment#description')
    appointment = Appointment.new(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect(appointment.description).to eq('Checkup with Jane Doe on ' + appointment.scheduled_at.strftime('%F'))
  end
end
