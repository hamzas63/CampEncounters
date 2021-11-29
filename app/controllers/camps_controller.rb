class CampsController < ApplicationController
  before_action :set_camp, only: %i[apply show already_signed]
  before_action :validate_camp_active, only: :apply

  def index
    @camp = Camp.all
  end

  def show; end

  def new
    @camp = Camp.new
  end

  def edit; end

  def create
    @camp = Camp.new(camp_params)

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

  def destroy
    @camp.destroy

    respond_to do |format|
      format.html { redirect_to camps_path, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def already_signed
     @application = current_user.applications.find_or_initialize_by(camp_id: @camp)
  if @application.persisted?
    session[:application_id] = @application.id
    redirect_to application_path(:index, application: @application)
  else
    redirect_to camp_path(@camp)
  end

  end

  def apply
    @application = current_user.applications.find_or_create_by(camp_id: @camp.id)
    session[:application_id] = @application.id
    if @application.progress.to_i.zero?
      redirect_to application_path(:step2, application: @application)
    else
      redirect_to application_path(:index, application: @application)
    end
  end

  private

  def validate_camp_active
    result = CheckDate.call(date1: @camp.end_date, date2: Date.today)
    return if result.success?

    redirect_to camps_path, notice: 'Please participate in next camp.'
  end

  def set_camp
    @camp = Camp.find(params[:id])
  end

  def camp_params
    params.require(:camp).permit(:name, :camp_type, :status, :start_date, :end_date, :registartion_date, location_ids:[], user_ids:[])
  end
end
