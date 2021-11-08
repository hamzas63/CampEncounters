class Admin::LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  # GET /locations or /locations.json
  def index
    if params[:query].present?
      @pagy, @locations = pagy(Location.search(params[:query]), items: 2)
    elsif sort_column and sort_direction
      @pagy, @locations = pagy(Location.order(sort_column + ' ' + sort_direction), items: 3)
    else
      @pagy, @locations = pagy(Location.all, items: 3)
    end
    respond_to do |format|
      format.html
      format.csv { send_data Location.all.to_csv, filename: "locations-#{Date.today}.csv" }
    end
  end

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find params[:id]
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to admin_locations_path, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to admin_locations_path, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to admin_locations_path, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name)
  end
end
