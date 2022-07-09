class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :employee, class_name: "Employee", foreign_key: "user_id"
  has_one :customer, class_name: "Customer", foreign_key: "user_id"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
