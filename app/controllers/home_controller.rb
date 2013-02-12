class HomeController < ApplicationController

  def index
  
    uid = get_poll_uid
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_unregistered_responses where uid = ?)", uid )
  
  end

  def home
    
    # todo: fix up this horribly inefficient code


    if (current_user.state_id)
      @governor_office = Office.where(:office_type_id => 5, :polity_type => 'State', :polity_id => current_user.state_id).first
      @us_senate_offices = Office.where(:office_type_id => 3, :polity_type => 'State', :polity_id => current_user.state_id)
      if (current_user.congressional_district_number)
        @us_house_offices = Office.where(:office_type_id => 4, 
                                        :polity_type => 'State', 
                                        :polity_id => current_user.state_id, 
                                        :seat_discriminator => current_user.congressional_district_number )
      end      
    end
    
    @open_quick_polls = QuickPoll.where("id not in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    @answered_quick_polls = QuickPoll.where("id in (select quick_poll_id from quick_poll_responses where user_id = ?)", current_user)
    
  end



end
