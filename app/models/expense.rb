class Expense < ActiveRecord::Base
  validates_presence_of :amount,:category,:date
  belongs_to :user
  belongs_to :category
end
