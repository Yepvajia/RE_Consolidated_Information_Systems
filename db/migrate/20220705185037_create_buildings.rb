class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.integer :customer_id
      t.integer :address_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :tech_name
      t.string :tech_email
      t.string :tech_phone

      t.timestamps
    end
  end
end
