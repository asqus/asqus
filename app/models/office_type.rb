class OfficeType < ActiveRecord::Base
  has_many :offices
  attr_accessible :description
  validates :description, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  validates :polity_type, :presence => true
  
  def to_s
    return description
  end


end
