class Employee < ApplicationRecord
  has_many :battery, class_name: "Battery", foreign_key: "employee_id"
end
