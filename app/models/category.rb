class Category < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :expense
  belongs_to :user
end
