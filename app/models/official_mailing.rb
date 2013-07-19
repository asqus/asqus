class OfficialMailing < ActiveRecord::Base
  belongs_to :official
  belongs_to :mailing_status
  has_many :quick_poll_mailings
  has_many :quick_polls, :through => :quick_poll_mailings
  
   
  def send_notifications()
  
    logger.debug "send_notifications called for official id " + official_id.to_s
    
    users = []
    quick_polls = []
    incumbent = Incumbent.find_by_official_id(official_id)
    
    unless incumbent.nil?
       unless quick_polls.empty?
        case incumbent.office_type_ukey
          when OfficeType::US_SENATOR
            users = User.where("rep_state_id = ?",incumbent.state_id)
          when OfficeType::US_REP
            users = User.where("rep_state_id = ? and rep_congressional_district_no = ?", incumbent.state_id, incumbent.congressional_district_no)
          when OfficeType::STATE_SENATOR
            users = User.where("rep_state_id = ? and rep_state_senate_district_key = ?", incumbent.state_id, incumbent.state_senate_district_key)
          when OfficeType::STATE_REP
            users = User.where("rep_state_id = ? and rep_state_house_district_key = ?", incumbent.state_id, incumbents.state_house_district_key)
        end
        users.each do |user|
          logger.debug "send_notifications sending mail to user " + user.email
          OfficialMailer.poll_notification_email(user,quick_polls,rep_message).deliver
        end
        official_mailing_status = MailingStatus::COMPLETE
        save()                        
      end
    end
       
  end
  
end

