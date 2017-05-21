class Expense < ActiveRecord::Base
  validates_presence_of :amount,:category,:date
  belongs_to :user
  belongs_to :category

  def display_amount
    if self.amount.to_s.split('.').last.size == 2
      self.amount.to_s
    else
      self.amount.to_s.concat("0")
    end
  end
end
