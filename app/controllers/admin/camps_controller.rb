class Admin::CampsController < AdminController
  include SearchSort
  before_action :set_camp, only: %i[show edit update destroy toggle_status]
  helper_method :sort_column, :sort_direction

  def index
    (@pagy, @camps) = pagy_search_sort(params[:query], Camp)
    respond_to do |format|
      format.html
      format.csv { send_data Camp.all.to_csv, filename: "camps-#{Date.today}.csv" }
    end
  end

  def show
    @camp = Camp.find(params[:id])
  end

  def new
    @camp = Camp.new
  end

  def edit; end

  def create
    @camp = Camp.new(camp_params)

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

  def destroy
    @camp.destroy

    respond_to do |format|
      format.html { redirect_to admin_camps_path, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_status
    @camp.toggle_status

    redirect_to admin_camps_path, notice: 'Camp status has been updated.'
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end

  def sort_column
    Camp.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def camp_params
    params.require(:camp).permit(:name, :camp_type, :status, :start_date, :end_date, :registartion_date, location_ids:[])
  end
end
