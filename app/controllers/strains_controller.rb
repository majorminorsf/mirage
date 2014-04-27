class StrainsController < ApplicationController
  before_action :set_strain, only: [:show, :edit, :update, :destroy, :rate, :add_to_order]
  before_filter :authorize_or_redirect, except: [:rate]

  def rate
    
  end
  def add_to_order
    quantity = params[:quantity].to_i
    current_order.add_item(@strain, quantity)
  end
  # GET /strains
  def index
    @strains = Strain.all
  end

  # GET /strains/1
  def show
    @current_order = current_order
  end

  # GET /strains/new
  def new
    @strain = Strain.new
  end

  # GET /strains/1/edit
  def edit
  end

  # POST /strains
  def create
    @strain = Strain.new(strain_params)

    if @strain.save
      redirect_to strains_path, notice: 'Strain was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /strains/1
  def update
    if @strain.update(strain_params)
      redirect_to strains_path, notice: 'Strain was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /strains/1
  def destroy
    @strain.destroy
    redirect_to strains_url, notice: 'Strain was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strain
      @strain = Strain.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def strain_params
      params.require(:strain).permit(:strain, :name, :thc, :cbd, :published, :photo, :description, :rating, :rates, :price, :featured)
    end
end
