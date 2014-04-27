class PagesController < ApplicationController
  before_filter :authorize_or_redirect, :only => :admin
  require 'ostruct'

  def index
    @snippets = Content.all ||= []
    @strains = Strain.all
  end
  def about
    @snippets = Content.all ||= []
    @strains = Strain.all
  end
  def membership
    @snippets = Content.all ||= []
    @strains = Strain.all
    @member = Member.new
  end
  def menu
    @feature = Strain.where('featured = ?', true).first
    @strains = Strain.all
    @snippets = Content.all ||= []
    @current_order = current_order
  end
  def admin
    @bodyclass = "admin"
    @users = User.all
  end
  
  def checkout
    @current_order = current_order
  end

  def contact
    @emails = []
    email = Struct.new(:email, :name)
    [{"email" => "test@test.com", "name" => "test"}].each do |hash|
      e = email.new(hash["email"], hash["name"])
      @emails.push(e)
    end
    @message = Message.new
    @newsletter = Newsletter.new
  end
  
  def ajax
    @response = "success"
  end
  
  def send_mail
  	@message = Message.new(params[:message])
  	email = params[:email]
  	subject = params[:subject]
  	sender = params[:from]
  	SendMail.email(sender, email, subject, @message).deliver
  	redirect_to root_path, :notice => "Email was delivered"
  end
  
end
