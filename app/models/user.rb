class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :expenses
  has_many :categories, through: :expenses
end
