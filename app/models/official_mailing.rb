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
       logger.debug "send_notification using incumbent " + incumbent.id.to_s
       unless quick_polls.empty?
        logger.debug "send_notification quick polls found"
        case incumbent.office_type_ukey
          when OfficeType::US_SENATOR
            logger.debug "send_notification incumbent is a US senator"
            users = User.where("rep_state_id = ?",incumbent.state_id)
          when OfficeType::US_REP
            logger.debug "send_notification incumbent is a US representative"
            users = User.where("rep_state_id = ? and rep_congressional_district_no = ?", incumbent.state_id, incumbent.congressional_district_no)
          when OfficeType::STATE_SENATOR
            logger.debug "send_notification incumbent is a state senator"
            users = User.where("rep_state_id = ? and rep_state_senate_district_key = ?", incumbent.state_id, incumbent.state_senate_district_key)
          when OfficeType::STATE_REP
            logger.debug "send_notification incumbent is a state representative"
            users = User.where("rep_state_id = ? and rep_state_house_district_key = ?", incumbent.state_id, incumbents.state_house_district_key)
          else
            logger.debug "send_notification incumbent is an invalid official type"
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

