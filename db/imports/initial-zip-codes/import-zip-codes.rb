
ActiveRecord::Base.transaction do

  puts 'PROCESSING ZIP CODE DATA'

  zips = TempImpZipCode.find(:all) 
  zips.each do |zip|
    
    puts 'finding state'
    state = State.find_by_abbreviation(zip.state_abbreviation)
    
    puts 'finding city'
    city = PostalCity.find_by_state_id_and_name(state.id,zip.name)
    if city.nil?
      puts 'creating city'
      city = PostalCity.create( {:state_id => state.id, :name => zip.name}, :without_protection => true )
    end
  
    puts 'creating zip code'
    zipcode = ZipCode.create({ :id => zip.id, :state_id => state.id, :postal_city_name => zip.name,
                               :latitude => zip.latitude, :longitude => zip.longitude }, :without_protection => true )
    
  end
  
  puts 'ZIP CODES IMPORTED SUCCESSFULLY'


end





