class UserMailer < ActionMailer::Base
  default from: "from@example.com"
   
  def thanks_for_voting_email(user)
    @user = user
    logger.debug "UserMailer::thanks_for_voting_email sending mail to " + user.email
    mail(to: @user.email, subject: 'Thanks for Voting!')
  end
  
  
end
