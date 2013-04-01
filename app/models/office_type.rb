class OfficeType < ActiveRecord::Base
  belongs_to :polity_type
  has_many :offices
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }
  validates :polity_type, :presence => true
  
  def to_s
    return self.name
  end

  POTUS = OfficeType.find_by_ukey('POTUS')
  VPOTUS = OfficeType.find_by_ukey('VPOTUS')
  US_SENATOR = OfficeType.find_by_ukey('US_SENATOR')
  US_REP = OfficeType.find_by_ukey('US_REP')
  GOVERNOR = OfficeType.find_by_ukey('GOVERNOR')
  LT_GOVERNOR = OfficeType.find_by_ukey('LT_GOVERNOR')
  STATE_SENATOR = OfficeType.find_by_ukey('STATE_SENATOR')
  STATE_REP = OfficeType.find_by_ukey('STATE_REP')
  MAYOR = OfficeType.find_by_ukey('MAYOR')
  US_HOUSE_DELEGATE = OfficeType.find_by_ukey('US_HOUSE_DELEGATE')
  
end
