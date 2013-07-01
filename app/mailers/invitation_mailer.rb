class InvitationMailer < ActionMailer::Base
  default from: "invitation@folioshine"
  
  def send_invitation(invitation)
    @greeting = "yo what's up?"
    
    mail to: "jesseocon@gmail.com", subject: 'The best email evaaaaar!!!'
  end
end
