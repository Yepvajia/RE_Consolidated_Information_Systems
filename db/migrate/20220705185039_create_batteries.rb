class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      t.integer :building_id
      t.string :building_type
      t.string :status
      t.integer :employee_id
      t.date :comm_date
      t.date :inspec_date
      t.integer :certificate
      t.text :information
      t.text :notes

      t.timestamps
    end
  end
end
