class AttachmentsController < ApplicationController
  before_filter :set_class
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /attachments
  def index
    @attachments = Attachment.all
  end

  # GET /attachments/1
  def show
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit
  end

  # POST /attachments
  def create
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      if params[:ajax].blank?
        redirect_to attachments_path, notice: 'Attachment was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /attachments/1
  def update
    if @attachment.update(attachment_params)
      redirect_to attachments_path, notice: 'Attachment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /attachments/1
  def destroy
    @attachment.destroy
    redirect_to attachments_url, notice: 'Attachment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attachment_params
      params.require(:attachment).permit(:label, :attached_file)
    end
    
    def set_class
      @bodyclass = "admin admin-page"
    end
end
