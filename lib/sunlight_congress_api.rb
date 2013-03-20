
module SunlightCongressAPI
  
  BaseURL = 'http://congress.api.sunlightfoundation.com'
    
public

  def self.legislatorsLocate(latitude, longitude)
    key = PRIVATE_CONFIG['sunlight_api_key']
    parms = { :apikey => key, :latitude => latitude, :longitude => longitude }     
    response = HTTParty.get(BaseURL + '/legislators/locate', :query => parms )
    parsed_response = JSON.parse(response.body).to_hash.with_indifferent_access
    legislators = parsed_response[:results]    
    return { :legislators => legislators, :http_response_code => response.code }
  end
  
    
end