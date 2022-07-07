class DataWareHouseRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection WAREHOUSE_DB
end