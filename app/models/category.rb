class Category < ActiveRecord::Base
  validates_presence_of :name
  has_many :expenses
  belongs_to :user

  def slug
    out = self.name.gsub(/[^a-zA-Z\d\s]/,"")
    out.gsub!(" ", "-")
    out.downcase
  end

  def self.find_by_slug(slug, user)
    self.all.find do |item|
      item.slug == slug && item.user == user
    end
  end

end
