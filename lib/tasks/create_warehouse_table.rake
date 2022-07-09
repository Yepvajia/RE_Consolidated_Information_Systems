require 'pg'

task create_warehouse_table: :environement do
    warehouse_db.exec "DROP TABLE IF EXISTS fact_quotes"
    warehouse_db.exec("CREATE TABLE fact_quotes(quote_id INTEGER PRIMARY KEY,creation_date DATE,company_name VARCHAR(225),email VARCHAR(225),nb_elevator INTEGER)")

    warehouse_db.exec "DROP TABLE IF EXISTS fact_contact"
    warehouse_db.exec("CREATE TABLE fact_contact(contact_id INTEGER PRIMARY KEY,creation_date DATE,company_name VARCHAR(225),email VARCHAR(225),project_name VARCHAR(225))")

    warehouse_db.exec "DROP TABLE IF EXISTS fact_elevator"
    warehouse_db.exec("CREATE TABLE fact_elevator(serial_number VARCHAR(225),comm_date VARCHAR(225),building_id INTEGER,customers_id INTEGER,building_city VARCHAR(225))")

    warehouse_db.exec "DROP TABLE IF EXISTS dim_customers"
    warehouse_db.exec("CREATE TABLE dim_customers(creation_date VARCHAR(225),company_name VARCHAR(225),company_main_contact_name VARCHAR(225),company_main_contact_email VARCHAR(225),nb_elevators INTEGER,customers_city VARCHAR(225))")
end
