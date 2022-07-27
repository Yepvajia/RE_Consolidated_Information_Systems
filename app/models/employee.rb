class Employee < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :battery, class_name: "Battery", foreign_key: "employee_id"
  has_one :intervention, class_name: "Intervention", foreign_key: "author_id"
  has_one :other_intervention, class_name: "Intervention", foreign_key: "employee_id"
end
