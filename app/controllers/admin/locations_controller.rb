class Admin::LocationsController < AdminController
  include SearchSort
  before_action :set_location, only: %i[show edit update destroy]
  helper_method :sort_column, :sort_direction

  def index
    (@pagy, @locations) = pagy_search_sort(params[:query], Location)
    respond_to do |format|
      format.html
      format.csv { send_data CsvGeneratorService.new(Location).to_csv_export, filename: "locations-#{Date.today}.csv" }
    end
  end

  def show
    @location = Location.find params[:id]
  end

  def new
    @location = Location.new
  end

  def edit; end

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

  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to admin_locations_path, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
