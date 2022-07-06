# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
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



# functions for data
def buildingAndBatteryID
  array = []
  for i in 0..39 do 
    array.append(i)
  end
  a = rand(40)
  return array[a]
end
#elevator model outputs a model type
def elevatorsModel
  array = ["Standard","Premium","Excelium"]
  a = rand(3)
  return array[a]
end
# type outputs a elevator type
def type
 array =["Residential","Commercial","Corporate"]
 a = rand(3)
 return array[a]
end

# status outputs a status 
def status
  array = ["Working_condition","needs_replacement","needs_to_be_inspected"]
  a = rand(3)
return array[a]
end
# employee id outputs a random number from 1 to 10 as thats the number on employee the company has
def employeeId
  array = []
  for i in 0..9 do 
    array.append(i)
  end
  a = rand(10)
  return array[a]
end
# floors outputs a number from 1 to 80 taking 80 as an imaginary number of floors
def floors
  array = []
  for i in 0..79 do 
    array.append(i)
  end
  a = rand(80)
  return array[a]
end

BuildingDetail.destroy_all
BuildingDetail.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

33.times do
  BuildingDetail.create!(
    building_id: buildingAndBatteryID(),
    key: Faker::Lorem.sentence(word_count: 1),
    value: Faker::Lorem.sentence(word_count: 1)
  )
  
end

Battery.destroy_all
Battery.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

40.times do
  Battery.create!(
    building_id: buildingAndBatteryID(),
    #type: type(),
    status: status(),
    employee_id: employeeId(),
    comm_date: Faker::Date.between(from: '2019-01-23', to: '2014-06-25'),
    inspec_date: Faker::Date.between(from: '2019-01-23', to: '2014-06-25'),
    certificate: Faker::Number.number(digits: 7),
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
  
end

Column.destroy_all
Column.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

55.times do
  Column.create!(
    battery_id: buildingAndBatteryID(),
    #type: type(),
    floors: floors(),
    status: status(),
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
  
end

Elevator.destroy_all
Elevator.connection.execute('ALTER TABLE users AUTO_INCREMENT = 1')

100.times do
  Elevator.create!(
    serial_number: Faker::IDNumber.spanish_foreign_citizen_number,
    model: elevatorsModel(),
    #type: type(),
    status: status(),
    comm_date: Faker::Date.between(from: '2019-01-23', to: '2014-06-25'),
    inspec_date: Faker::Date.between(from: '2019-01-23', to: '2014-06-25'),
    certificate: Faker::Number.number(digits: 7),
    information: Faker::Lorem.sentence(word_count: 3),
    notes: Faker::Lorem.sentence(word_count: 5)
  )
  
end

