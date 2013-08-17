class State < ActiveRecord::Base
  
  has_many :congressional_districts
  has_many :state_senate_districts
  has_many :state_house_districts
  has_many :counties
  has_many :municipalities
  has_many :offices
  has_many :postal_cities
  
  attr_accessible :abbreviation, :name

  validates_presence_of :name, :abbreviation

  def to_s
    return name
  end

end
