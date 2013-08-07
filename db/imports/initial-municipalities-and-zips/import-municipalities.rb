
ActiveRecord::Base.transaction do

  puts 'PROCESSING MUNICIPALITY DATA'

  places = TempImpCensusPlace.find(:all) 
  places.each do |place|
    state = State.find_by_abbreviation(place.state_abbreviation)
    
    muni_type = nil
    case place.type_code
      when 'A', 'N' 
        muni_type= MunicipalityType::INCORPORATED_PLACE
      when 'S' 
        muni_type = MunicipalityType::CENSUS_DESIGNATED_PLACE
    end
    
    
    unless muni_type.nil?  
      name = place.name.gsub(/ city| town| village| municipality| CDP$/,'') 
      municipality = Municipality.create( {:ansi_code => place.ansi_code, :state_id => state.id, 
                                         :municipality_type_id => muni_type.id, :name => name },
                                         :without_protection => true )
    end
  end
  
  puts 'MUNICIPALITIES IMPORTED SUCCESSFULLY'


end





