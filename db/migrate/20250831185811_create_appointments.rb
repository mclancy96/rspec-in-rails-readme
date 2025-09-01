class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.string :reason

      t.timestamps
    end
  end
end
