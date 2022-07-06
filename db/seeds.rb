# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

40.times do
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

Address.destroy_all
Address.connection.execute('ALTER TABLE addresses AUTO_INCREMENT = 1')

40.times do |i|
  Address.create!(
    status: "juice"
  )
end

Customer.destroy_all
Customer.connection.execute('ALTER TABLE customers AUTO_INCREMENT = 1')

40.times do |i|
  user = User.find(i+11)
  Customer.create!(
    user_id: i + 11,
    creation_date: Faker::Date.between(from: 3.years.ago, to: Date.today),
    company_name: Faker::Company.unique.name,
    address_id: i + 1,
    name: Faker::Name.unique.name,
    phone: Faker::PhoneNumber.unique.cell_phone,
    email: user.email,
    description: Faker::Lorem.paragraph,
    auth_name: Faker::Name.unique.name,
    auth_phone: Faker::PhoneNumber.unique.cell_phone,
    mangr_email: Faker::Internet.unique.email
  )
end

Building.destroy_all
Building.connection.execute('ALTER TABLE buildings AUTO_INCREMENT = 1')

40.times do |i|
  customer = Customer.find(i+1)
  Building.create!(
    customer_id: i + 1,
    address_id: i + 1,
    name: customer.name,
    email: customer.email,
    phone: customer.phone,
    tech_name: Faker::Name.unique.name,
    tech_email: Faker::Internet.unique.email,
    tech_phone: Faker::PhoneNumber.unique.cell_phone
  )
  # puts customer.address.status
end

# Lead.create!([{
#   name: Faker::Name.unique.name,
#   company_name: 
#   email:
#   phone:
#   project_name:
#   description:

# }])