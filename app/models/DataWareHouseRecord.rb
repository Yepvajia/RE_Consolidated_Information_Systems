require 'pg'

class DataWareHouseRecord < ActiveRecord::Base
  self.table_name = 'fact_intervention'
  self.abstract_class = true
  establish_connection :postgres
end