class OfficeType < ActiveRecord::Base
  has_many :offices
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  validates :polity_type, :presence => true
  
  def to_s
    return self.name
  end


end
