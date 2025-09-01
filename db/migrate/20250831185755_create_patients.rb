class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.date :date_of_birth

      t.timestamps
    end
  end
end
