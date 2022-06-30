# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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