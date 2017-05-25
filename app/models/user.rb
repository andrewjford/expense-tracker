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

  def expenses_by_category_and_month(category,month)
    self.expenses.find_all do |expense|
      expense.category == category && expense.date.month == month
    end
  end

  def total_expenses_by_category(month)
    #returns hash with category as key and total dollars as value

    #get only expenses from given month
    expenses = self.expenses_by_month(month)
    hash = {}
    #collect totals by category in hash
    self.categories.each do |category|
      hash[category] = expenses.sum do |expense|
        expense.category == category ? expense.amount : expense.amount*0
      end
    end
    hash
  end

  def get_monthly_totals(month)
    #wrapper for total_expenses_by_category
    #returns a hash that is converted to proper presentation using #last_decimal
    #returns a total
    hash = self.total_expenses_by_category(month)
    out = {}
    out[:hash] = self.last_decimal(hash)
    out[:grand_total] = hash.sum {|key,value| value}
    out
  end

  def last_decimal(hash)
    #Adds zero to cents column if stored without one (ex. $12.5)
    #converts values to string and adds a zero if only one decimal point
    new_hash = {}
    hash.each do |key,value|
      if value.to_s.split('.').last.size == 2 #if stored with 2 decimals
        new_hash[key] = value.to_s
      elsif value.to_s.split('.').size == 1 #if no number is stored, only 1 in array
        new_hash[key] = value.to_s
      else                                  #else is num with 1 decimal
        new_hash[key] = value.to_s.concat("0")
      end
    end
    new_hash
  end

  def populate_default_categories
    #method to be run when new user is created
    Category.create(name: "Apparel", user: self)
    Category.create(name: "Dining Out", user: self)
    Category.create(name: "Entertainment", user: self)
    Category.create(name: "Groceries", user: self)
    Category.create(name: "Transportation", user: self)
    Category.create(name: "Travel", user: self)
    Category.create(name: "Utilities", user: self)
  end
end
