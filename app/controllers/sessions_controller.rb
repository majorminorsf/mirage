class SessionsController < Devise::SessionsController
  before_filter :set_class

  private
  
  def set_class
    @bodyclass = "user"
  end
end