class OfficialMailer < ActionMailer::Base
  default from: "info@asq.us"
  
  def poll_notification_email(user, incumbent, quick_polls, rep_message)
    @user = user
    @incumbent = incumbent
    @quick_polls = quick_polls
    @rep_message = rep_message
    mail(to: @user.email, subject: 'New Polls on Asq.us')
  end
  
  
end
