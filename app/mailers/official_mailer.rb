class OfficialMailer < ActionMailer::Base
  default from: "notifications@asq.us"
  
  def poll_notification_mailer(user, quick_polls)
    @user = user
    @quick_polls = quick_polls
    mail(to: @user.email, subject: 'New Polls on Asq.us')
  end
  
  
end
