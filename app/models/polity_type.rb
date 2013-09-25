class PolityType < ActiveRecord::Base

  NATION = PolityType.find_by_name('Nation');
  STATE = PolityType.find_by_name('State');  
  SENATE_SEAT = PolityType.find_by_name('SenateSeat');    
  CONGRESSIONAL_DISTRICT = PolityType.find_by_name('CongressionalDistrict');
  STATE_SENATE_DISTRICT = PolityType.find_by_name('StateSenateDistrict');
  STATE_HOUSE_DISTRICT = PolityType.find_by_name('StateHouseDistrict');
  COUNTY = PolityType.find_by_name('County');
  MUNICIPALITY = PolityType.find_by_name('Municipality');
  WARD = PolityType.find_by_name('Ward');
 
end
