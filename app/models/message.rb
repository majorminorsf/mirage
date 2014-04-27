class Message
    include ActiveAttr::Model
    include ActiveModel::Validations

    attribute :email
    attribute :body
    attribute :subject
    #attr_accessible :email, :body, :subject

    validates_presence_of :email
    validates :email, :email_format => { :message => "Not a valid email address"}

end