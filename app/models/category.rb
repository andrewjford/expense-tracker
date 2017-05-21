class Category < ActiveRecord::Base
  validates_presence_of :name
  has_many :expenses
  belongs_to :user

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
