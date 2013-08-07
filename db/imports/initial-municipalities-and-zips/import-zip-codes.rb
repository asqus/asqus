
ActiveRecord::Base.transaction do

  puts 'PROCESSING ZIP CODE DATA'

  zips = TempImpZipCode.find(:all) 
  zips.each do |zip|
    
    state = State.find_by_abbreviation(zip.state_abbreviation)
    
    # do our best to find the municipality
    
    municipality_ansi_code = nil
    municipality = Municipality.find_by_state_id_and_name(state.id,zip.name)
    unless municipality.nil?
      municipality_ansi_code = municipality.ansi_code
    end
        
    zipcode = ZipCode.create({ :id => zip.id, :state_id => state.id, :municipality_ansi_code => municipality_ansi_code,
                               :latitude => zip.latitude, :longitude => zip.longitude }, :without_protection => true )
    
  end
  
  puts 'ZIP CODES IMPORTED SUCCESSFULLY'


end





