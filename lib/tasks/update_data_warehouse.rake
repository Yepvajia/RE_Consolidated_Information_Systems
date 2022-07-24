require 'pg'
require 'mysql2'
require 'faker'


namespace :db_warehouse do
    
    warehouse_db = PG.connect( host: "codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com", dbname: 'roc_elv_db_warehouse', :user => 'codeboxx', :password => 'Codeboxx1!' )
    # warehouse_db = PG.connect :dbname => 'roc_elv_db_warehouse'

    task reset: :environment do
        Rake::Task["db_warehouse:create_warehouse_table"].invoke
        Rake::Task["db_warehouse:seed"].invoke
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
        
        warehouse_db.exec "DROP TABLE IF EXISTS fact_intervention"
        warehouse_db.exec("CREATE TABLE fact_intervention(employee_id INTEGER, building_id INTEGER, battery_id INTEGER[], column_id INTEGER[], elevator_id INTEGER[], start_date VARCHAR(225), end_date VARCHAR(225), result VARCHAR(225), report VARCHAR(225), status VARCHAR(225))")
    end

    task seed: :environment do
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

        80.times do |i|
            e_id = rand(Employee.count)+1
            b_id = rand(Building.count)+1
            # e_id = i+1
            # b_id = i+1
            bat_id = Battery.where(building_id: b_id).map{|battery| battery.id} 
            col_id = Column.where(battery_id: bat_id).map{|column| column.id}
            elv_id = Elevator.where(column_id: col_id).map{|elevator| elevator.id}
            bat_id = bat_id.empty? ? 'NULL' : "ARRAY #{bat_id}"
            col_id = col_id.empty? ? 'NULL' : "ARRAY #{col_id}"
            elv_id = elv_id.empty? ? 'NULL' : "ARRAY #{elv_id}" 
            # pp "NEW BUILDING #{b_id}"
            # pp bat_id
            # pp col_id
            # pp elv_id
            result = ['Success', 'Failure', 'Incomplete'].sample
            # status = ['Pending', 'InProgress', 'Interrupted', 'Resumed', 'Complete'].sample
            status = ['Complete'].sample
            
            warehouse_db.exec("INSERT INTO fact_intervention(employee_id, building_id, battery_id, column_id, elevator_id, start_date, end_date, result, report, status) VALUES ('#{e_id}', '#{b_id}', #{bat_id}, #{col_id}, #{elv_id}, '#{Faker::Date.between(from: 1.year.ago, to: Date.today)}', '#{Faker::Date.between(from: Date.today, to: 1.year.from_now)}', '#{result}', '#{Faker::Lorem.paragraph}', '#{status}')")
        end
    end

    task show: :environment do
        question1 = warehouse_db.exec("SELECT COUNT(contact_id), DATE_TRUNC('month',creation_date) AS month FROM fact_contact GROUP BY DATE_TRUNC('month',creation_date) ORDER BY DATE_TRUNC('month',creation_date) ASC")
        puts ""
        puts "The number of unique contact requests grouped by Month"
        puts ""
        fact_contact_year = question1.first["month"].to_s[0,4] 
        puts "****FOR YEAR : #{fact_contact_year}****"
        question1.find_all do |q_1|
            year = q_1["month"].to_s[0,4]
            if fact_contact_year.to_i > year.to_i - 1
                puts q_1
            else
                puts "****FOR YEAR : #{year.to_i } ****"
                fact_contact_year = fact_contact_year.to_i + 1
            end
        end
        question2 = warehouse_db.exec("SELECT COUNT(quote_id), DATE_TRUNC('month',creation_date) AS month FROM fact_quote GROUP BY DATE_TRUNC('month',creation_date) ORDER BY DATE_TRUNC('month',creation_date) ASC")
        puts ""
        puts "The number of unique quote requests grouped by Month"
        puts ""
        fact_quote_year = question2.first["month"].to_s[0,4] 
        puts "****FOR YEAR : #{fact_quote_year}****"
        question2.find_all do |q_2|
            year = q_2["month"].to_s[0,4]
            if fact_quote_year.to_i > year.to_i - 1
                puts q_2
            else
                puts "****FOR YEAR : #{year.to_i } ****"
                fact_quote_year = fact_quote_year.to_i + 1
            end
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