class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.integer :user_id
      t.date :creation_date
      t.string :company_name
      t.integer :address_id
      t.string :name
      t.string :phone
      t.string :email
      t.text :description
      t.string :auth_name
      t.string :auth_phone
      t.string :mangr_email

      t.timestamps
    end
  end
end
