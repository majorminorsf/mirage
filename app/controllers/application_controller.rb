class ApplicationController < ActionController::Base
  protect_from_forgery
  #require 'truncate_html' # string.truncate_html(0, at_end = "&hellip;").html_safe
  after_filter :store_location
  before_filter :init_attachments
  
  def current_order
    if session[:order_id]
      if Order.find_by_id(session[:order_id]).blank? || Order.find_by_id(session[:order_id]).created_at < (Time.now - 7.days)
        @current_order = Order.create!
        session[:order_id] = @current_order.id
      else
        @current_order ||= Order.find(session[:order_id])
      end
    end
    if session[:order_id].nil?
      @current_order = Order.create!
      session[:order_id] = @current_order.id
    end
    @current_order
  end
  
  def init_attachments
    @attachments = Attachment.all
    @attachment = Attachment.new
  end
  
  def authorize_or_redirect
    if user_signed_in?
      redirect_to session[:originating_url] || root_path, notice: "Not authorized" unless current_user.admin?
    else
      redirect_to login_path, notice: "Not authorized"
    end
  end
  
  def store_location
   # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (!request.fullpath.include?("sign_in") && \
        !request.fullpath.include?("sign_up") && \
        !request.fullpath.include?("account") && \
        request.fullpath != "/login" && \
        request.fullpath != "/logout" && \
        request.fullpath != "/register" && \
        !request.fullpath.include?("password") && \
        !request.xhr?) # don't store ajax calls
      session[:originating_url] = request.fullpath 
    end
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || session[:originating_url] || root_path
  end
  def after_update_path_for(resource)
    session[:originating_url] || root_path
  end
  def after_sign_out_path_for(resource_or_scope)
    session[:originating_url] || root_path
  end
  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end
  def after_resetting_password_path_for(resource)
    root_path
  end
end
