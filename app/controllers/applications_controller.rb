class ApplicationsController < ApplicationController
  before_action :set_application
  after_action :set_progress, only: [:update]

  include Wicked::Wizard

  steps :step2, :step3, :step4, :step5, :step6, :step7, :step8, :step9, :step10, :step11, :index, :application_view

  def index
    @applications =  Application.all
  end

  def show
    render_wizard
  end

  def new
    @application = Application.new
  end

  def update
    @application.update(application_params)
    render_wizard @application
  end

  private

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @application.progress = ((wizard_steps.index(step) + 3).to_d / wizard_steps.count.to_d) * 100
      @application.save
    else
      @application.progress = 0
    end
  end

  def set_application
    @application = Application.find_by_id(session[:application_id])
  end

  def application_params
    params.require(:application).permit(:gender, :dob, :blood_group, :occupation, :nationality, :martial_status, :confirmation_email, :weight, :height, :progress, :allergy, :medicine)
  end
end
