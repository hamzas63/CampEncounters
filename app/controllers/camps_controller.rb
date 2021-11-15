class CampsController < ApplicationController
  before_action :set_camp
  # GET /camps or /camps.json
  def index
    @camp = Camp.all
  end

  # GET /camps/1 or /camps/1.json
  def show
    #@camp.users = User.find(params[:camp][:user_ids].reject(&:blank?))
    #@camp.user = current_user.id
    @camp = Camp.find(params[:id])
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    #@camplocation = Camplocation.all
  end

  # GET /camps/1/edit
  def edit; end

  # POST /camps or /camps.json
  def create
    @camp = Camp.new(camp_params)
    #@camp.locations = Location.find(params[:camp][:location_ids].reject(&:blank?))

    respond_to do |format|
      if @camp.save
        format.html { redirect_to camps_path, notice: 'Camp was successfully created.' }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1 or /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to camps_path, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1 or /camps/1.json
  def destroy
    @camp.destroy

    respond_to do |format|
      format.html { redirect_to camps_path, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def registration
    @camp = Camp.find(params[:id])
    @date_now = Date.today
    if @camp.start_date > @date_now
      @registration = Registration.find_or_create_by(user_id: current_user.id, camp_id: params[:id])
      session[:registration_id]=@registration.id
      if @registration.progress.nil?
        redirect_to registration_path(:step2, registration: @registration)
      else
        redirect_to registration_path(:index, registration: @registration)
      end
    else
      redirect_to camps_path, notice: 'Please participate in next camp.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_camp
    #@camp = Camp.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def camp_params
    params.require(:camp).permit(:name, :camp_type, :status, :start_date, :end_date, :registartion_date, location_ids:[], user_ids:[])
  end
end
