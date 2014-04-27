class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy, :approve, :reissue]

  def approve
    @member.update(approved: !@member.approved?)
    @member.approve_member
    redirect_to members_path
  end
  def reissue
    @member.reissue
    redirect_to members_path
  end
  # GET /members
  def index
    @members = Member.all
  end

  # GET /members/1
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      SendMail.email('mekkagojira@gmail.com', member_params[:email], "Thank you", Message.new(body: "Please wait for approval")).deliver
      redirect_to membership_path
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :address, :unit, :city, :zip_code, :phone_number, :email, :doctor_or_clinic_name, :doctor_recommendation, :ca_proof_of_residency, :approved, :code)
    end
end
