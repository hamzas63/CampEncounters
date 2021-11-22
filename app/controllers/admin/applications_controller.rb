class Admin::ApplicationsController < AdminController
  before_action :set_application , only: %i[ show edit update destroy ]

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def edit; end

  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to admin_applications_path, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to admin_applications_path, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @application.destroy

    respond_to do |format|
      format.html { redirect_to admin_applications_path, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:gender, :dob, :blood_group, :occupation, :nationality, :martial_status, :confirmation_email, :weight, :height, :progress, :allergy, :medicine)
  end
end
