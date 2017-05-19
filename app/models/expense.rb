class Expense < ActiveRecord::Base
  validates_presence_of :amount,:category,:date
  belongs_to :user
  has_one :category
end
