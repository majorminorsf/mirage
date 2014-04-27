class NewslettersController < ApplicationController
  before_action :set_newsletter, only: [:show, :edit, :update, :destroy]

  # GET /newsletters
  def index
    @newsletters = Newsletter.all
  end

  # GET /newsletters/1
  def show
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters
  def create
    @newsletter = Newsletter.new(newsletter_params)

    if @newsletter.save
      SendMail.email('mekkagojira@gmail.com', newsletter_params[:email], "Thank you", Message.new(body: "Welcome")).deliver
      redirect_to @newsletter, notice: 'Newsletter was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /newsletters/1
  def update
    if @newsletter.update(newsletter_params)
      redirect_to @newsletter, notice: 'Newsletter was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /newsletters/1
  def destroy
    @newsletter.destroy
    redirect_to newsletters_url, notice: 'Newsletter was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end
end
