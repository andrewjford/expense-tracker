class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :expenses
  has_many :categories

  def self.name_available?(name)
    self.all.none? do |user|
      user.username.downcase == name.downcase
    end
  end
end
