class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :status
      t.string :enity
      t.string :num_street
      t.string :apt_suite
      t.string :city
      t.string :postal_code
      t.string :country
      t.text :notes

      t.timestamps
    end
  end
end
