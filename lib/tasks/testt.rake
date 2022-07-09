require "mysql2"

client = Mysql2::Client.new(:host => "localhost", :password => "razakade123", :database => "roc_elv_db")
task :testt do
    results = client.query("SELECT city FROM buildings INNER JOIN addresses ON buildings.address_id = addresses.id")
    5.times do
        puts results
    end
    # results.each do |row|
    #       puts row
    #   end
end