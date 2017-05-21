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
end
