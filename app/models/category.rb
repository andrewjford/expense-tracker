class Category < ActiveRecord::Base
  validates_presence_of :name
  has_many :expenses
  belongs_to :user

end
