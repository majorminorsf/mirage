class Newsletter < ActiveRecord::Base
  attr_accessible :email
  validates_presence_of :email
  validates :email, :email_format => { :message => "Not a valid email address"}
end
