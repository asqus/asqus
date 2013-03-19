
class MapQuest
  
public

  def self.geoCode(location)
    key = PRIVATE_CONFIG['mapquest_api_key']
    parms = { :key => key, :callback => :renderOptions, :location => location, :format => :csv }     
    response = HTTParty.get('http://www.mapquestapi.com/geocoding/v1/address', :query => parms )
    parsed_response = CSV.parse(response, :headers => true)
    locations = []
    parsed_response.each do |row|
      locations.push(row.to_hash.with_indifferent_access)
    end  
    return { :locations => locations, :http_response_code => response.code }
    
  end
  
    
  
end