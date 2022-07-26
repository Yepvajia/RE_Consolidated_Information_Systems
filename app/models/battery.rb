class Battery < ApplicationRecord
  belongs_to :building, class_name: "Building", foreign_key: "building_id"
  belongs_to :employee, class_name: "Employee", foreign_key: "employee_id"
  has_many :columns, class_name: "Column", foreign_key: "battery_id"
  has_one :intervention, class_name: "Intervention", foreign_key: "employee_id"
end
