class SendMail < ActionMailer::Base
  default :from => "mekkagojira@gmail.com"
  
  def email(sender, email, subject, message)
  	@message = message
  	@sender = sender
  	mail :to => email, :subject => subject, :from => sender
  end
  
end
