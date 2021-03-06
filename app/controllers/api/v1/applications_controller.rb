module Api
  module V1
    class ApplicationsController < ActionController::API

      def index
        applications = Application.all
        render json: applications
      end

      def show
        application = Application.find(params[:id])
        render json: application
      end

      def create
        application = Application.new(application_params)
        if application.save
          render json: application
        else
          render json: { error: application.errors.full_messages.to_sentence }
        end
      end

      private

      def application_params
        params.require(:application).permit(:gender, :dob, :blood_group, :occupation, :nationality, :martial_status, :confirmation_email, :weight, :height, :progress, :allergy, :medicine, :camp_id, :user_id)
      end
    end
  end
end
