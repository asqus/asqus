class OfficialMailer < ActionMailer::Base
  default from: "info@asq.us"
  
  def poll_notification_email(user, quick_polls, rep_message)
    @user = user
    @quick_polls = quick_polls
    @rep_message = rep_message
    mail(to: @user.email, subject: 'New Polls on Asq.us')
  end
  
  
end
