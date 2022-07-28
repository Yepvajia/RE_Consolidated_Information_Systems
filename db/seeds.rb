# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
require_relative "func"
require 'json'
Faker::UniqueGenerator.clear # ONLY NEEDED ONCE AT THE TOP

User.destroy_all
User.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

User.create!([{
  admin: 1,
  email: "mathieu.houde@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "patrick.thibault@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "francis.patry-jessop@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "david.amyot@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "marie-eve.goupil@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "francois.boivin@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "timothy.wever@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "kiril.kleinerman@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "felicia.hartono@codeboxx.biz",
  password: "juicejuice"
},
{
  admin: 1,
  email: "eileen.ai@codeboxx.biz",
  password: "juicejuice"
}])


30.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "juicejuice")
end

Employee.destroy_all
Employee.connection.execute('ALTER TABLE employees AUTO_INCREMENT = 1')

Employee.create!([{
  first_name: "Mathieu",
  last_name: "Houde",
  title: "Gopher",
  email: "mathieu.houde@codeboxx.biz",
  user_id: 1
},
{
  first_name: "Patrick",
  last_name: "Thibault",
  title: "Maximalist",
  email: "patrick.thibault@codeboxx.biz",
  user_id: 2
},
{
  first_name: "Francis",
  last_name: "Patry-Jessop",
  title: "Captain",
  email: "francis.patry-jessop@codeboxx.biz",
  user_id: 3
},
{
  first_name: "David",
  last_name: "Amyot",
  title: "The Man",
  email: "david.amyot@codeboxx.biz",
  user_id: 4
},
{
  first_name: "Marie-Ève",
  last_name: "Goupil",
  title: "AI Master",
  email: "marie-eve.goupil@codeboxx.biz",
  user_id: 5
},
{
  first_name: "François",
  last_name: "Boivin",
  title: "The Tank",
  email: "francois.boivin@codeboxx.biz",
  user_id: 6
},
{
  first_name: "Timothy",
  last_name: "Wever",
  title: "Beard whisperer",
  email: "timothy.wever@codeboxx.biz",
  user_id: 7
},
{
  first_name: "Kiril",
  last_name: "Kleinerman",
  title: "I <3 Winnipeg",
  email: "kiril.kleinerman@codeboxx.biz",
  user_id: 8
},
{
  first_name: "Felicia",
  last_name: "Hartono",
  title: "Scrums are too early",
  email: "felicia.hartono@codeboxx.biz",
  user_id: 9
},
{
  first_name: "Eileen",
  last_name: "Ai",
  title: "They really are.",
  email: "eileen.ai@codeboxx.biz",
  user_id: 10
}])

Quote.destroy_all
Quote.connection.execute('ALTER TABLE quotes AUTO_INCREMENT = 1')

40.times do
  Quote.create!(
    building_type: type(),
    price: elevatorsModel(),
    number_of_apartments: rand(100),
    number_of_companies: rand(100),
    number_of_corporations: rand(100),
    number_of_floors: rand(100),
    number_of_basements: rand(100),
    number_of_parking_spots: rand(100),
    number_of_elevators: rand(100),
    maximum_occupancy: rand(100),
    business_hours: rand(24),
    date: Faker::Date.between(from: 3.years.ago, to: Date.today)
  )
end

Lead.destroy_all
Lead.connection.execute('ALTER TABLE leads AUTO_INCREMENT = 1')
departments = ["Support", "HR", "Juice", "Elevator Heads", "IT"]
40.times do
  Lead.create!(
    name: Faker::Name.unique.name.gsub(/\'/, ''),
    company_name: Faker::Company.unique.name.gsub(/\'/, ''),
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.unique.cell_phone,
    project_name: Faker::Movie.unique.title.gsub(/\'/, ''),
    description: Faker::Lorem.paragraph,
    department: departments[rand(departments.count)],
    message: Faker::Lorem.paragraph,
    date: Faker::Date.between(from: 3.years.ago, to: Date.today)
  )
end

Address.destroy_all
Address.connection.execute('ALTER TABLE addresses AUTO_INCREMENT = 1')

file = File.read('db/addresses.json')
data = JSON.parse(file)
# puts data


40.times do |i|
  address = data['addresses'][i]
  Address.create!(
    address_type: data['address_type'][rand(4)],
    status: 'active',
    enity: data['enity'][rand(2)],
    num_street: address['address1'],
    apt_suite: address['address2'],
    city: address['city'],
    postal_code: address['postalCode'],
    country: 'US, ' + address['state'],
    lat: address['coordinates']['lat'],
    lng: address['coordinates']['lng'],
    notes: Faker::Lorem.paragraph
  )
end

Customer.destroy_all
Customer.connection.execute('ALTER TABLE customers AUTO_INCREMENT = 1')


(Address.count/2).times do |i|
  user = User.find(i+11)
  Customer.create!(
    user_id: i + 11,
    creation_date: Faker::Date.between(from: 3.years.ago, to: Date.today),
    company_name: Faker::Company.unique.name.gsub(/\'/, ''),
    address_id: ((i+1.0)/2.0).ceil,
    name: Faker::Name.unique.name.gsub(/\'/, ''),
    phone: Faker::PhoneNumber.unique.cell_phone,
    email: user.email,
    description: Faker::Lorem.paragraph,
    auth_name: Faker::Name.unique.name.gsub(/\'/, ''),
    auth_phone: Faker::PhoneNumber.unique.cell_phone,
    mangr_email: Faker::Internet.unique.email
  )
end

Building.destroy_all
Building.connection.execute('ALTER TABLE buildings AUTO_INCREMENT = 1')

c_arr = Array(1..Customer.count)
c_arr += c_arr
c_arr.shuffle
Address.count.times do |i|
  c_id = c_arr.pop()
  customer = Customer.find(c_id)
  Building.create!(
    customer_id: (c_id).ceil,
    address_id: i + 1,
    name: customer.name.gsub(/\'/, ''),
    email: customer.email,
    phone: customer.phone,
    tech_name: Faker::Name.unique.name.gsub(/\'/, ''),
    tech_email: Faker::Internet.unique.email,
    tech_phone: Faker::PhoneNumber.unique.cell_phone
  )
  # puts customer.address.status
end

BuildingDetail.destroy_all
BuildingDetail.connection.execute('ALTER TABLE building_details AUTO_INCREMENT = 1')


60.times do
  BuildingDetail.create!(
    building_id: buildingID(),
    key: Faker::Lorem.sentence(word_count: 1),
    value: Faker::Lorem.sentence(word_count: 1)
  )
  
end

Battery.destroy_all
Battery.connection.execute('ALTER TABLE batteries AUTO_INCREMENT = 1')

b_arr = Array(1..Building.count)
b_arr += b_arr + b_arr
b_arr = b_arr.shuffle
120.times do |i|
  b_id = b_arr.pop()
  Battery.create!(
    building_id: b_id,
    building_type: type(),
    status: 'active',
    employee_id: employeeId(),
    comm_date: Faker::Date.between(from: '2019-01-23', to: '2022-06-25'),
    inspec_date: Faker::Date.between(from: '2019-01-23', to: '2022-06-25'),
    certificate: Faker::Number.number(digits: 7),
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
  
end

Column.destroy_all
Column.connection.execute('ALTER TABLE columns AUTO_INCREMENT = 1')

bat_arr = Array(1..Battery.count)
bat_arr += bat_arr
bat_arr = bat_arr.shuffle
240.times do |i|
  bat_id = bat_arr.pop()
  Column.create!(
    battery_id: bat_id,
    building_type: type(),
    floors: floors(),
    status: 'active',
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
  
end

Elevator.destroy_all
Elevator.connection.execute('ALTER TABLE elevators AUTO_INCREMENT = 1')

col_arr = Array(1..Column.count)
col_arr += col_arr
col_arr = col_arr.shuffle
480.times do |i|
  col_id = col_arr.pop()
  Elevator.create!(
    column_id: col_id,
    serial_number: Faker::IDNumber.spanish_foreign_citizen_number,
    model: elevatorsModel(),
    building_type: type(),
    elevator_status: ['active', 'inactive'].sample,
    comm_date: Faker::Date.between(from: '2019-01-23', to: '2022-06-25'),
    inspec_date: Faker::Date.between(from: '2019-01-23', to: '2022-06-25'),
    certificate: Faker::Number.number(digits: 7),
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
end

Intervention.destroy_all
Intervention.connection.execute('ALTER TABLE interventions AUTO_INCREMENT = 1')

10.times do |i|
  Intervention.create!(
    author_id: i + 1,
    customer_id: i + 1,
    building_id: i + 1,
    battery_id: i + 1,
    column_id: i + 1,
    elevator_id: i + 1,
    employee_id: i + 1,
    start_date: Date.today,
    end_date: Date.today
  )
end