class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.integer :battery_id
      t.string :building_type
      t.integer :floors
      t.string :status
      t.string :information
      t.text :notes

      t.timestamps
    end
  end
end
