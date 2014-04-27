class UsersController < ApplicationController
  before_filter :set_class
  before_filter :authorize_or_redirect, :except => :deassimilate

  def edit
    @user = User.find(params[:id])
  end

  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      else
        @user.reset_password_token = 'temp'
        @user.save!
        @user.reset_password!(params[:user][:password], params[:user][:password_confirmation])
      end
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end
  
  def assimilate
    original_user = current_user
    new_user = User.find(params[:id])
    if original_user.admin?
      original_user.update_attribute("assimilated", true)
      new_user.update_attribute("user_id", original_user.id)
      sign_in new_user, :bypass => true
      redirect_to root_path, notice: "Signed in as #{new_user.email}"
    else
      redirect_to root_path, notice: "Not authorized"
    end
  end
  
  def deassimilate
    original_user = User.find(current_user.user_id)
    if original_user.assimilated?
      current_user.update_attribute("user_id", current_user.id)
      original_user.update_attribute("assimilated", false)
      sign_in original_user, :bypass => true
      redirect_to admin_path, notice: "Signed in as #{original_user.email}"
    else
      redirect_to root_path, notice: "Not authorized"
    end
  end
  
  private
  
  def set_class
    @bodyclass = "admin admin-page"
  end
end