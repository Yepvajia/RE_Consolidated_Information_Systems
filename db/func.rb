# functions for data
def buildingID
  a = rand(Building.count)
  return a + 1
end
def batteryID
  a = rand(Battery.count)
  return a + 1
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
# def status
#   array = ["Working_condition","needs_replacement","needs_to_be_inspected"]
#   a = rand(3)
# return array[a]
# end
# employee id outputs a random number from 1 to 10 as thats the number on employee the company has
def employeeId
  a = rand(Employee.count)
  return a + 1
end
# floors outputs a number from 10 to 80 taking 80 as an imaginary number of floors
def floors
  a = rand(80)
  return a + 10
end
# this function creates the random number between 1 to 55 as there are 55 col
def columnID
  a = rand(Column.count)
  return a + 1
end