class Admin::RegistrationsController < ApplicationController
  before_action :set_registration , only: %i[ show edit update destroy ]
  # GET /registrations or /registrations.json
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1 or /registrations/1.json
  def show
    #@registration.users = User.find(params[:registration][:user_ids].reject(&:blank?))
    #@registration.user = current_user.id
    @registration = Registration.find(params[:id])
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
    #@registrationlocation = Registrationlocation.all
  end

  # GET /registrations/1/edit
  def edit; end

  # POST /registrations or /registrations.json
  def create
    @registration = Registration.new(registration_params)
    #@registration.locations = Location.find(params[:registration][:location_ids].reject(&:blank?))

    respond_to do |format|
      if @registration.save
        format.html { redirect_to admin_registrations_path, notice: 'Registration was successfully created.' }
        format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrations/1 or /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to admin_registrations_path, notice: 'Registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1 or /registrations/1.json
  def destroy
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to admin_registrations_path, notice: 'Registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_registration
    @registration = Registration.find(params[:id])
    #@registration = Registration.find_by_id(session[:registration_id])
  end

  # Only allow a list of trusted parameters through.
  def registration_params
    params.require(:registration).permit(:gender, :dob, :blood_group, :occupation, :nationality, :martial_status, :confirmation_email, :weight, :height, :progress, :allergy, :medicine)
  end
end
