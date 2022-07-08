require 'pg'
require 'mysql2'

warehouse_db = PG.connect :dbname => 'roc_elv_db_warehouse'

namespace :db_warehouse do

    task init: :environment do
        Rake::Task["db_warehouse:create_warehouse_table"].invoke
        Rake::Task["db_warehouse:insert_data"].invoke
    end

    task create_warehouse_table: :environment do
        warehouse_db.exec "DROP TABLE IF EXISTS fact_quotes"
        warehouse_db.exec("CREATE TABLE fact_quote(quote_id INTEGER PRIMARY KEY,creation_date DATE,company_name VARCHAR(225),email VARCHAR(225),nb_elevator INTEGER)")
    
        warehouse_db.exec "DROP TABLE IF EXISTS fact_contact"
        warehouse_db.exec("CREATE TABLE fact_contact(contact_id INTEGER PRIMARY KEY,creation_date DATE,company_name VARCHAR(225),email VARCHAR(225),project_name VARCHAR(225))")
    
        warehouse_db.exec "DROP TABLE IF EXISTS fact_elevator"
        warehouse_db.exec("CREATE TABLE fact_elevator(serial_number VARCHAR(225),comm_date VARCHAR(225),building_id INTEGER,customer_id INTEGER,building_city VARCHAR(225))")
    
        warehouse_db.exec "DROP TABLE IF EXISTS dim_customers"
        warehouse_db.exec("CREATE TABLE dim_customers(creation_date VARCHAR(225),company_name VARCHAR(225),company_main_contact_name VARCHAR(225),company_main_contact_email VARCHAR(225),nb_elevators INTEGER,customers_city VARCHAR(225))")
    end

    task insert_data: :environment do
        #    insert data from customers to fact_quote
        Customer.find_each do |c|
        #    insert data to fact_quote
            Quote.find_each do |q|
                warehouse_db.exec("INSERT INTO fact_quote(quote_id,creation_date,nb_elevator,company_name,email) VALUES (#{q.id},'#{q.created_at}',#{q.number_of_elevators},'#{c.company_name}','#{c.email}')")
            end
        end

        #    insert data to fact_contact
        Lead.find_each do |l|
            warehouse_db.exec("INSERT INTO fact_contact(contact_id,creation_date,company_name,email,project_name) VALUES (#{l.id},'#{l.created_at}',#{l.company_name},'#{l.email}','#{l.project_name}')")
        end

        #    insert data  to fact_elevator
        Customer.find_each do |c|
            Building.find_each do |b|
                Elevator.find_each do |e|
                    warehouse_db.exec("INSERT INTO fact_elevator(serial_number,comm_date,building_id,customers_id,building_city) VALUES (#{e.serial_number},'#{e.comm_date}',#{b.id},#{c.id},'#{c.address.city}')")
                end
            end
        end
         #    insert data  to dim_customers
        Customer.find_each do |c|
            Elevator.find_each do |e|
                warehouse_db.exec("INSERT INTO dim_customers(creation_date,company_name,full_name_of_company_main_contact,email_of_company_main_contact,nb_elevators,customer_city) VALUES ('#{c.creation_date}','#{c.company_name}','#{c.auth_name}','#{c.mangr_email}',,'#{c.address.city}')")
            end
        end

            
    end
end