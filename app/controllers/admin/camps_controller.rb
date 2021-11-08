class Admin::CampsController < ApplicationController
  before_action :set_camp, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  # GET /camps or /camps.json
  def index
    if params[:query].present?
      @pagy, @camps = pagy(Camp.search(params[:query]), items: 2)
    elsif sort_column and sort_direction
      @pagy, @camps = pagy(Camp.order(sort_column + ' ' + sort_direction), items: 3)
    else
      @pagy, @camps = pagy(Camp.all, items: 3)
    end

    respond_to do |format|
      format.html
      format.csv { send_data Camp.all.to_csv, filename: "camps-#{Date.today}.csv" }
    end
  end

  # GET /camps/1 or /camps/1.json
  def show
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
        format.html { redirect_to admin_camps_path, notice: 'Camp was successfully created.' }
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
        format.html { redirect_to admin_camps_path, notice: 'Camp was successfully updated.' }
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
      format.html { redirect_to admin_camps_path, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_camp
    @camp = Camp.find(params[:id])
  end

  def sort_column
    Camp.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  # Only allow a list of trusted parameters through.
  def camp_params
    params.require(:camp).permit(:name, :camp_type, :status, :start_date, :end_date, :registartion_date, location_ids:[])
  end
end
