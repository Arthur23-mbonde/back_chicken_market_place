class FarmersController < ApplicationController
  before_action :set_farmer, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ index edit update create destroy ]

  # GET /farmers or /farmers.json
  def index

    # If user's logged in and is a breeder, render index page for farmers
    if current_user && current_user.role == "Eleveur"
      @farmers = current_user.farmer
      @farmers = Farmer.all

    # If user's logged in and is a buyer, render home page for buyer
    else
      redirect_to root_path
    end

  end

  # GET /farmers/1 or /farmers/1.json
  def show
    # set_farmer
  end

  # GET /farmers/new
  def new
    @farmer = Farmer.new
  end

  # GET /farmers/1/edit
  def edit
  end

  # POST /farmers or /farmers.json
  def create

    # Create a farmer with foreign_key (user_id) added by back_end code
    @farmer = Farmer.new(farmer_params)
    @farmer.user = current_user

    respond_to do |format|
      if @farmer.save
        format.html { redirect_to farmer_url(@farmer), notice: "Farmer was successfully created." }
        format.json { render :show, status: :created, location: @farmer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @farmer.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /farmers/1 or /farmers/1.json
  def update
    respond_to do |format|
      if @farmer.update(farmer_params)
        format.html { redirect_to farmer_url(@farmer), notice: "Farmer was successfully updated." }
        format.json { render :show, status: :ok, location: @farmer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @farmer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farmers/1 or /farmers/1.json
  def destroy
    @farmer.destroy!

    respond_to do |format|
      format.html { redirect_to farmers_url, notice: "Farmer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farmer
      @farmer = Farmer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def farmer_params

      #Params customized
      #params.require(:farmer).permit(:name, :address, :description, :user_id)
      params.require(:farmer).permit(:name, :address, :description)

    end
end
