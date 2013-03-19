
class OpenStatesAPI
  
  BaseURL = 'http://openstates.org/api/v1'
    
public

  def self.legislatorsGeo(latitude, longitude)
    key = PRIVATE_CONFIG['sunlight_api_key']
    parms = { :apikey => key, :lat => latitude, :long => longitude }     
    response = HTTParty.get(BaseURL + '/legislators/geo', :query => parms )
    parsed_response = JSON.parse(response.body)
    legislators = []
    parsed_response.each do |legislator|
      legislators.push(legislator.to_hash.with_indifferent_access)
    end
    return { :legislators => legislators, :http_response_code => response.code }
  end
  
    
end