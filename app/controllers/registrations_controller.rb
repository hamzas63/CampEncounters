class RegistrationsController < ApplicationController
  before_action :set_registration
  after_action :set_progress, only: [:update]

  include Wicked::Wizard

  steps :step2, :step3, :step4, :step5, :step6, :step7, :step8, :step9, :step10, :step11, :index, :application_view


  def index
    @registrations =  Registration.all
  end

  def show
    # @registration =Registration.find(params[:registration_id])
    render_wizard
  end

  def new
    @registration = Registration.new
  end

  def update
    case step
      when :step2
        @registration.update(registration_params)
      when :step3
        @registration.update(registration_params)
      when :step4
        @registration.update(registration_params)
      when :step5
        @registration.update(registration_params)
      when :step6
        @registration.update(registration_params)
      when :step7
        @registration.update(registration_params)
      when :step8
        @registration.update(registration_params)
      when :step9
        @registration.update(registration_params)
      when :step10
        @registration.update(registration_params)
      when :step11
        @registration.update(registration_params)
    end
    render_wizard @registration
  end

  private

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @registration.progress = ((wizard_steps.index(step) + 3).to_d / wizard_steps.count.to_d) * 100
      @registration.save
    else
      @registration.progress = 0
    end
  end

  def set_registration
    @registration = Registration.find_by_id(session[:registration_id])
    #@registration = Registration.find_by(user_id: current_user.id)
    #@registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:gender, :dob, :blood_group, :occupation, :nationality, :martial_status, :confirmation_email, :weight, :height, :progress, :allergy, :medicine)
  end
end
