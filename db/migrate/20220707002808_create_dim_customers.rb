class CreateDimCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      t.datetime :creation_date
      t.string :company_name
      t.string :full_name_of_company_main_contact
      t.string :email_of_company_main_contact
      t.integer :nb_elevators
      t.string :customer_city

      t.timestamps
    end
  end
end
