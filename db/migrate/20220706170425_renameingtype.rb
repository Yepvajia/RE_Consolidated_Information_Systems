class Renameingtype < ActiveRecord::Migration[5.2]
  def change
  rename_column(:batteries, :type, :building_type)
  rename_column(:columns, :type, :building_type)
  rename_column(:elevators, :type, :building_type)
  end
end
