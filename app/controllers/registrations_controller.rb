class RegistrationsController < Devise::RegistrationsController
  before_filter :set_class
  def new
    super
  end
  def edit
    super
  end
  
  protected

  def after_sign_up_path_for(resource)
    #admin_path
    root_path
  end
  def after_update_path_for(resource)
    if current_user.admin?
      admin_path
    else
      root_path
    end
  end
  
  private
  
  def set_class
    @bodyclass = "user"
  end
end