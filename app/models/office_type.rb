class OfficeType < ActiveRecord::Base
  has_many :offices
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  validates :polity_type, :presence => true
  
  def to_s
    return self.name
  end

  POTUS = OfficeType.find('POTUS')
  VPOTUS = OfficeType.find('VPOTUS')
  US_SENATOR = OfficeType.find('US_SENATOR')
  US_REP = OfficeType.find('US_REP')
  GOVERNOR = OfficeType.find('GOVERNOR')
  LT_GOVERNOR = OfficeType.find('LT_GOVERNOR')
  STATE_SENATOR = OfficeType.find('STATE_SENATOR')
  STATE_REP = OfficeType.find('STATE_REP')
  MAYOR = OfficeType.find('MAYOR')
  US_HOUSE_DELEGATE = OfficeType.find('US_HOUSE_DELEGATE')
  
end
