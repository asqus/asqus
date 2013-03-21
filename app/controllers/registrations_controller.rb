class RegistrationsController < Devise::RegistrationsController
  
def update
  
   user_hash = params[:user]
   
   # todo check to see if address has changed before locating reps again
   
   if (user_hash[:rep_state_id] && user_hash[:address1] && user_hash[:city])
     state = State.find(user_hash[:rep_state_id].to_i)
     address = user_hash[:address1] + ',' + user_hash[:city] + ',' + state.abbreviation
     if (user_hash[:zip])
       address += ' ' + user_hash[:zip]
     end
     #
     # try to geocode
     #
     geo = MapQuestAPI.geoCode(address)
     if (geo[:http_response_code] == 200)
       #
       # todo: what if multiple locations returned?
       #
       geolocation = geo[:locations].first
       user_hash[:latitude] = geolocation[:Lat]
       user_hash[:longitude] = geolocation[:Lng]
       
       #
       # try to find congress members & therefore congressional district
       #
       
       user_hash[:rep_congressional_district_no] = nil
       cong = SunlightCongressAPI::legislatorsLocate(user_hash[:latitude], user_hash[:longitude])
       if (cong[:http_response_code] == 200)
         cong[:legislators].each do |leg|
           if (leg[:chamber] == 'house')
             user_hash[:rep_congressional_district_no] = leg[:district]
           end
         end
       end
       
       #
       # try to find state legislators and therefore state house, senate districts
       #
       
       legis = OpenStatesAPI::legislatorsGeo(user_hash[:latitude],user_hash[:longitude])
       legis[:legislators].each do |leg|
         if (leg[:chamber] == 'upper')
           user_hash[:rep_state_senate_district_key] = leg[:district]
         else
           user_hash[:rep_state_house_district_key] = leg[:district]
         end
       end      
       
     end #if valid geocode response
   end #if address filled in
   

   # call superclass update method
   super   
  
   
end

end
