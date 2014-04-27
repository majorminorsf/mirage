class PasswordsController < Devise::PasswordsController
  before_filter :set_class
  
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      respond_with({}, :location => root_path)
    else
      respond_with(resource)
    end
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end
  def after_resetting_password_path_for(resource)
    root_path
  end

  private
  
  def set_class
    @bodyclass = "user"
  end
end