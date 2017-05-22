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
    self.last_decimal(hash)
  end

  def last_decimal(hash)
    #converts values to string and adds a zero if only one decimal point
    new_hash = {}
    hash.each do |key,value|
      if value.to_s.split('.').last.size == 2
        new_hash[key] = value.to_s
      else
        new_hash[key] = value.to_s.concat("0")
      end
    end
    new_hash
  end

  def slug
    out = self.name.lowercase.gsub(/[^a-zA-Z\d\s]/,"")
    out.gsub!(" ","-")
    out.downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |item|
      item.slug == slug
    end
  end
end
