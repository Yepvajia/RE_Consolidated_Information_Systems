namespace :juice do
  task test: :environment do
    total = 0
    total_elv = 0
    Address.all.count.times do |i|
      address = Address.find(i+1)
      building = Building.where(address: address)
      batteries = Battery.where(building: building)
      columns_count = 0
      floors_count = 0
      elevators_count = 0
      batteries.each do |battery|
        columns = Column.where(battery: battery)
        columns_count += columns.count
        total += columns.count
        columns.each do |column|
          floors_count += column.floors
          elevators = Elevator.where(column: column)
          elevators_count += elevators.count
          total_elv += elevators.count
        end
      end
      puts "Address For #{address.id}: " + "#{address.num_street}, #{address.city}, #{address.country}, #{address.postal_code}"
      puts "Num Bat For #{address.id}: " + batteries.count.to_s
      puts "Num Col For #{address.id}: " + columns_count.to_s
      puts "Num Elv For #{address.id}: " + elevators_count.to_s
      puts "Num Floors For #{address.id}:" + floors_count.to_s
      puts "Name For #{address.id}: " + building[0].customer.name
      puts "Name Of Tech For #{address.id}: " + building[0].tech_name
      puts ""

      # puts address.building.batteries.columns.id
    end
  end

  task test2: :environment do
    file = Lead.find(102).file
    pp file
  end


# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid
  task test3: :environment do
    from = SendGrid::Email.new(email: 'sevada.rostomian@gmail.com')
    to = SendGrid::Email.new(email: 'sevada.rostomian@gmail.com')
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = SendGrid::Mail.new(from, subject, to, content)
    attachments.inline["logo.png"] = File.read("#{Rails.root}app/assets/images/R4.png")

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

    task test4: :environment do
    conn = PG.connect( dbname: 'roc_elv_db_warehouse' )
    conn.exec( "SELECT * FROM fact_intervention" ) do |result|
      result.each do |row|
        puts row.values
      end
    end
  end
end