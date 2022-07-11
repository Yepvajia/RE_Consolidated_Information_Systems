require 'pg'
require 'mysql2'
require 'faker'


namespace :db_warehouse do
    
    warehouse_db = PG.connect( host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", dbname: 'roc_elv_db_warehouse', :user => 'codeboxx', :password => 'Codeboxx1!' )

    task reset: :environment do
        Rake::Task["db_warehouse:create_warehouse_table"].invoke
        Rake::Task["db_warehouse:insert_data"].invoke
        Rake::Task["db_warehouse:show"].invoke
    end

    task create_warehouse_table: :environment do
        warehouse_db.exec "DROP TABLE IF EXISTS fact_quote"
        warehouse_db.exec("CREATE TABLE fact_quote(quote_id INTEGER ,creation_date DATE,company_name TEXT,email VARCHAR(225),nb_elevator INTEGER)")
    
        warehouse_db.exec "DROP TABLE IF EXISTS fact_contact"
        warehouse_db.exec("CREATE TABLE fact_contact(contact_id INTEGER ,creation_date DATE,company_name TEXT,email VARCHAR(225),project_name VARCHAR(225))")
    
        warehouse_db.exec "DROP TABLE IF EXISTS fact_elevator"
        warehouse_db.exec("CREATE TABLE fact_elevator(serial_number VARCHAR(225),comm_date VARCHAR(225),building_id INTEGER,customer_id INTEGER,building_city VARCHAR(225))")
    
        warehouse_db.exec "DROP TABLE IF EXISTS dim_customers"
        warehouse_db.exec("CREATE TABLE dim_customers(creation_date VARCHAR(225),company_name TEXT,company_main_contact_name VARCHAR(225),company_main_contact_email VARCHAR(225),nb_elevators INTEGER,customer_city VARCHAR(225))")
    end

    task insert_data: :environment do
        #    insert data to fact_quote
        var = 1
        Quote.find_each do |q|
            warehouse_db.exec("INSERT INTO fact_quote(quote_id,creation_date,nb_elevator,company_name,email) VALUES (#{var},'#{Faker::Date.between(from: '2019-01-23', to: '2022-06-25')}',#{q.number_of_elevators},'#{Faker::Company.unique.name.gsub(/\'/, '')}','#{Faker::Internet.email}')")
            var += 1
        end

        #    insert data to fact_contact
        var_2 = 1
        30.times do
            warehouse_db.exec("INSERT INTO fact_contact(contact_id,creation_date,company_name,email,project_name) VALUES (#{var_2},'#{Faker::Date.between(from: '2019-01-23', to: '2022-06-25')}','#{Faker::Company.unique.name.gsub(/\'/, '')}','#{Faker::Internet.email}','#{Faker::Movie.unique.title.gsub(/\'/, '')}')")
            var_2 += 1
        end

        #    insert data  to fact_elevator
        Elevator.find_each do |e|
            b_id = rand(10)
            c_id = rand(10)
            warehouse_db.exec("INSERT INTO fact_elevator(serial_number,comm_date,building_id,customer_id,building_city) VALUES ('#{e.serial_number}','#{e.comm_date}',#{b_id},#{c_id},'#{Faker::Address.city.gsub(/\'/, '')}')")
        end

         #    insert data  to dim_customers
        Customer.find_each do |c|
            var = rand(30)
            warehouse_db.exec("INSERT INTO dim_customers(creation_date,company_name,company_main_contact_name,company_main_contact_email,nb_elevators,customer_city) VALUES ('#{c.creation_date}','#{c.company_name}','#{c.auth_name}','#{c.mangr_email}',#{var},'#{Faker::Address.city.gsub(/\'/, '')}}')")
        end
    end

    task show: :environment do
        question1 = warehouse_db.exec("SELECT COUNT(contact_id), creation_date FROM fact_contact GROUP BY (creation_date)")
        puts ""
        puts "The number of unique requests (ContactId) grouped by Month"
        puts ""
        question1.find_all do |q_1|
            puts q_1
        end
        question2 = warehouse_db.exec("SELECT COUNT(quote_id), creation_date FROM fact_quote GROUP BY (creation_date)")
        puts ""
        puts "The number of unique requests (QuoteId) grouped by Month"
        puts ""
        question2.find_all do |q_2|
            puts q_2
        end
        question3 = warehouse_db.exec("SELECT nb_elevators, company_main_contact_name FROM dim_customers")
        puts ""
        puts "The number of elevators (ElevatorId) contained in the buildings belonging to each customer"
        puts ""
        question3.find_all do |q_3|
            puts q_3
        end
    end
end