class DataWareHouseRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :ware_house
end