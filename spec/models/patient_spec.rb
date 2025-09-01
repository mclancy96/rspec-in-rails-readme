require 'rails_helper'

RSpec.describe Patient, type: :model do
  it 'is valid with valid attributes' do
    patient = Patient.new(name: 'John Doe', date_of_birth: '1980-01-01')
    expect(patient).to be_valid
  end

  it 'is invalid without a name' do
    patient = Patient.new(name: nil, date_of_birth: '1980-01-01')
    expect(patient).not_to be_valid
  end

  it 'is invalid without a date_of_birth' do
    patient = Patient.new(name: 'Jane Doe', date_of_birth: nil)
    expect(patient).not_to be_valid
  end

  it 'can have many appointments' do
    patient = Patient.create!(name: 'John Doe', date_of_birth: '1980-01-01')
    appointment1 = Appointment.create!(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    appointment2 = Appointment.create!(patient: patient, scheduled_at: 2.days.from_now, reason: 'Follow-up')
    expect(patient.appointments).to include(appointment1, appointment2)
  end

  it 'destroys associated appointments when destroyed' do
    patient = Patient.create!(name: 'John Doe', date_of_birth: '1980-01-01')
    Appointment.create!(patient: patient, scheduled_at: 1.day.from_now, reason: 'Checkup')
    expect { patient.destroy }.to change { Appointment.count }.by(-1)
  end

  it 'returns the correct age' do
    patient = Patient.new(name: 'John Doe', date_of_birth: 20.years.ago.to_date)
    expect(patient.age).to be_within(1).of(20)
  end

  it 'returns upcoming appointments' do
    patient = Patient.create!(name: 'John Doe', date_of_birth: '1980-01-01')
    past = Appointment.create!(patient: patient, scheduled_at: 2.days.ago, reason: 'Past')
    future = Appointment.create!(patient: patient, scheduled_at: 2.days.from_now, reason: 'Future')
    expect(patient.upcoming_appointments).to include(future)
    expect(patient.upcoming_appointments).not_to include(past)
  end

  it 'returns full name (pending)' do
    pending('Implement Patient#full_name')
    patient = Patient.new(name: 'John Doe', date_of_birth: '1980-01-01')
    expect(patient.full_name).to eq('John Doe')
  end

  it 'returns patients with appointments today (pending)' do
    pending('Implement Patient.with_appointments_today')
    expect(Patient.with_appointments_today).to be_a(ActiveRecord::Relation)
  end
end
