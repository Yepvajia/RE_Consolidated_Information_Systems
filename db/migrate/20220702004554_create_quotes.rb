class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :building_type
      t.string :price
      t.integer :number_of_apartments
      t.integer :number_of_companies
      t.integer :number_of_corporations
      t.integer :number_of_floors
      t.integer :number_of_basements
      t.integer :number_of_parking_spots
      t.integer :number_of_elevators
      t.integer :maximum_occupancy
      t.integer :business_hours
      t.date :date, default: Date.today

      t.timestamps
    end
  end
end
