class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :customers, class_name: "Customer", foreign_key: "user_id"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
