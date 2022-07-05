class Address < ApplicationRecord
  has_one :customers, class_name: "Customer", foreign_key: "address_id"
  has_many :building, class_name: "Building", foreign_key: "customer_id"
end
