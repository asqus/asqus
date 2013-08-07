class OfficialMailing < ActiveRecord::Base
  belongs_to :official
  belongs_to :mailing_status
  has_many :quick_poll_mailings
  has_many :quick_polls, :through => :quick_poll_mailings
  
   
  def send_notifications()
  
    logger.debug "send_notifications called for official id " + official_id.to_s
    
    quick_polls = []
    incumbent = Incumbent.find_by_official_id(official_id)
    
    unless incumbent.nil?
      logger.debug "send_notification using office " + incumbent.office_id.to_s
      unless self.quick_polls.empty?
        logger.debug "send_notification quick polls found"
        users = incumbent.office.get_constituents(true)
        users.each do |user|
          logger.debug "send_notifications sending mail to user " + user.email
          OfficialMailer.poll_notification_email(user,incumbent,self.quick_polls,rep_message).deliver
        end
        self.mailing_status= MailingStatus::COMPLETE
        save!                     
      end
    end
       
  end
  
end

