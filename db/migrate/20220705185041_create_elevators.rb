class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.integer :column_id
      t.string :serial_number
      t.string :model
      t.string :building_type
      t.string :elevator_status
      t.date :comm_date
      t.date :inspec_date
      t.integer :certificate
      t.text :information
      t.text :notes

      t.timestamps
    end
  end
end
