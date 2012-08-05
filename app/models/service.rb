class Service < ActiveRecord::Base
  attr_accessible :title, :category
  has_many :providers

  def self.search(search)
    search.blank? ? [] : all(:conditions => ['title LIKE ?', "%#{search.strip}%"])
end
  
end
