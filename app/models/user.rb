class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :categories
  has_many :expenses, through: :categories

  def self.name_available?(name)
    self.all.none? do |user|
      user.username.downcase == name.downcase
    end
  end

  def expenses_by_category(category)
    #returns array of expense objects that have the given category
    self.expenses.find_all do |expense|
      expense.category == category
    end
  end

  def expenses_by_vendor(vendor)
    #returns array of expense objects that have the given vendor string
    self.expenses.find_all do |expense|
      expense.vendor == vendor
    end
  end

  def expenses_by_month(month)
    #returns array of expense objects that are in the month argument
    #argument must be integer
    self.expenses.find_all do |expense|
      expense.date.month == month
    end
  end
end
