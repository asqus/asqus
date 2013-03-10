class HomeController < ApplicationController

  def index
  
    uid = get_poll_uid
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
  
  end

  def home
    
    # todo: fix up this horribly inefficient code

    @staff_incumbent = nil
    if (current_user.staff_official)
      @staff_incumbent = Incumbent.where( :official_id => current_user.staff_official )
    end

    if (current_user.state_id)
      @governor_office = Office.where(:office_type_id => OfficeType::GOVERNOR.id, :state_id => current_user.state_id).first
      @us_senate_offices = Office.where(:office_type_id => OfficeType::US_SENATOR.id, :state_id => current_user.state_id)
      if (current_user.congressional_district_no)
        @us_house_offices = Office.where(:office_type_id => OfficeType::US_REP.id, 
                                        :state_id => current_user.state_id, 
                                        :congressional_district_no => current_user.congressional_district_no)
      end      
    end
    
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    
  end



end
