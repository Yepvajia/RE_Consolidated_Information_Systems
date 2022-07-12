namespace :juice do
  task test: :environment do
    total = 0
    total_elv = 0
    40.times do |i|
      address = Address.find(i+1)
      building = Building.where(address: address)
      batteries = Battery.where(building: building)
      columns_count = 0
      elevators_count = 0
      batteries.each do |battery|
        columns = Column.where(battery: battery)
        columns_count += columns.count
        total += columns.count
        columns.each do |column|
          elevators = Elevator.where(column: column)
          elevators_count += elevators.count
          total_elv += elevators.count
        end
      end
      puts "Num Bat For #{address.id}: " + batteries.count.to_s
      puts "Num Col For #{address.id}: " + columns_count.to_s
      puts "Num Elv For #{address.id}: " + elevators_count.to_s
      puts ""

      # puts address.building.batteries.columns.id
    end
    puts total
    puts total_elv
  end
end