namespace :update_data_warehouse do
    mysql_db = ActiveRecord::Base.establish_connection()
    warehouse_db = ActiveRecord::Base.establish_connection(WAREHOUSE_DB)

    
end
