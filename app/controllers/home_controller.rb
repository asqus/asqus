class HomeController < ApplicationController

  def index
  
    uid = get_poll_uid
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
  
  end

  def home

    @staff_incumbent = nil
    if (current_user.staff_official)
      @staff_incumbent = Incumbent.where( :official_id => current_user.staff_official )
    end
    
    logger.info "geocoding"

    @geocode_response = MapQuest.geoCode('60 Bonney, Steilacoom, WA')

    logger.info "response code: " + @geocode_response[:http_response_code].to_s 
    latitude = 0
    longitude = 0
    @geocode_response[:locations].each do |location|
      latitude = location[:Lat]
      longitude = location[:Lng]
      logger.info 'lat: ' + latitude.to_s + ' lng: ' + longitude.to_s 
    end
    
    
    logger.info "locating congressmen"
    
    @congress_response = SunlightCongressAPI::legislatorsLocate(latitude, longitude)
    
    logger.info "resp: " + @congress_response.to_s
    logger.info "http response: " + @congress_response[:http_response_code].to_s
    @congress_response[:legislators].each do |leg|
      logger.info "leg: " + leg[:bioguide_id]
    end

    @legislators_response = OpenStatesAPI::legislatorsGeo(latitude,longitude)
    @legislators_response[:legislators].each do |leg|
      logger.info 'legislator: ' + leg[:last_name]
    end
    
    if (current_user.rep_state_id)

      @governor = Incumbent.where(:office_type_id => OfficeType::GOVERNOR.id, :state_id => current_user.rep_state_id)
      @us_senators = Incumbent.where(:office_type_id => OfficeType::US_SENATOR.id, :state_id => current_user.rep_state_id)

      if (current_user.rep_congressional_district_no)
        @us_rep = Incumbent.where(:office_type_id => OfficeType::US_REP.id, 
                                   :state_id => current_user.rep_state_id, 
                                   :congressional_district_no => current_user.rep_congressional_district_no).first
      end    
      if (current_user.rep_state_senate_district_key)
        @state_senators = Incumbent.where(:office_type_id => OfficeType::STATE_SENATOR.id, 
                                          :state_id => current_user.rep_state_id, 
                                          :state_senate_district_key => current_user.rep_state_senate_district_key)
      end     
      if (current_user.rep_state_house_district_key)
        @state_reps = Incumbent.where(:office_type_id => OfficeType::STATE_REP.id, 
                                   :state_id => current_user.rep_state_id, 
                                   :state_house_district_key => current_user.rep_state_house_district_key)
      end     
        
    end
    
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    


    
  end



end
