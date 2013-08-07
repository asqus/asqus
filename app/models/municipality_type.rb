class MunicipalityType< ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 32 }


  
  INCORPORATED_PLACE = MunicipalityType.find_by_name('Incorporated Place');
  CENSUS_DESIGNATED_PLACE = MunicipalityType.find_by_name('Census Designated Place');  
  
  
end