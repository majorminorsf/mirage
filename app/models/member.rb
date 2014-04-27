class Member < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :address, :unit, :city, :zip_code, :phone_number, :email, :doctor_or_clinic_name, :doctor_recommendation, :ca_proof_of_residency, :approved, :code
  has_attached_file :doctor_recommendation
  has_attached_file :ca_proof_of_residency
  has_many :orders
  
  def full_name
    "#{first_name} #{last_name}"
  end
  def full_address
    "#{address} #{unit}<br>#{city} #{zip_code}"
  end
  def approve_member
    if self.approved?
      randomString = (0...8).map { (65 + rand(26)).chr }.join
      self.update(code: randomString)
      @message = Message.new(body: "Your code is: #{randomString}")
    	email = self.email
    	subject = "You've been approved!"
    	sender = "mekkagojira@gmail.com"
    	SendMail.email(sender, email, subject, @message).deliver
    else
      self.update(code: "")
    end
  end
  
  def reissue
    randomString = (0...8).map { (65 + rand(26)).chr }.join
    self.update(code: randomString)
    @message = Message.new(body: "Your code is: #{randomString}")
  	email = self.email
  	subject = "Your new code!"
  	sender = "mekkagojira@gmail.com"
  	SendMail.email(sender, email, subject, @message).deliver
  end
end
