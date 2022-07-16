class Building < ApplicationRecord
  belongs_to :address, class_name: "Address", foreign_key: "address_id"
  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id"
  has_many :building_details, class_name: "BuildingDetail", foreign_key: "building_id"
  has_many :batteries, class_name: "Battery", foreign_key: "building_id"
end
