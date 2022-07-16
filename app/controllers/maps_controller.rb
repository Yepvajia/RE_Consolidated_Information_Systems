class MapsController < ApplicationController
  def index
    if current_user
      if current_user.admin != 1
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
    @addresses = Address.all
    @hash = Gmaps4rails.build_markers(@addresses) do |address, marker|
      marker.lat address.lat
      marker.lng address.lng
      marker.picture({
        "url" => "https://i.imgur.com/fxXHGT7.png",
        "width" =>  64,
        "height" => 64})
      arr = getAddressInfo(address)
      marker.infowindow '<div id="content">' +
                          '<div id="siteNotice">' +
                          "</div>" +
                          '<h3 id="firstHeading" class="firstHeading">' +arr[0]+ '</h1>' +
                          '<div id="bodyContent">' +
                            "<p>Number of floors: " + arr[1] + "</p>" +
                            "<p>Client name: " + arr[2] + "</p>" +
                            "<p>Number of Batteries: " + arr[3] + "</p>" +
                            "<p>Number of Columns: " + arr[4] + "</p>" +
                            "<p>Number of Elevators: " + arr[5] + "</p>" +
                            "<p>Name of technical contact: " + arr[6] + "</p>" +
                          "</div>" +
                        "</div>"
    end
  end

  def getAddressInfo(address)
    building = Building.where(address: address)
    batteries = Battery.where(building: building)
    columns_count = 0
    floors_count = 0
    elevators_count = 0
    batteries.each do |battery|
      columns = Column.where(battery: battery)
      columns_count += columns.count
      columns.each do |column|
        floors_count += column.floors
        elevators = Elevator.where(column: column)
        elevators_count += elevators.count
      end
    end
    full_address = "#{address.num_street}, #{address.city}, #{address.country}, #{address.postal_code}"
    num_floors = floors_count.to_s
    cus_name = building[0].customer.name
    num_bat = batteries.count.to_s
    num_col = columns_count.to_s
    num_elv = elevators_count.to_s
    tech_name = building[0].tech_name
    return [full_address,num_floors,cus_name,num_bat,num_col,num_elv,tech_name]
  end
end
