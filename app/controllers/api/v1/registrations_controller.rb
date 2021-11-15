module Api
  module V1
    class RegistrationsController < ApplicationController

      #protect_from_forgery prepend: true
      skip_before_action :verify_authenticity_token

      ALLOWED_DATA = %[gender occupation nationality].freeze

      def index
        registrations = Registration.all
        render json: registrations
      end

      def show
        registration = Registration.find(params[:id])
        render json: registration
      end

      def create
        data = json_payload.select {|k| ALLOWED_DATA.include?(k)}
        registration = Registration.new(data)
        if registration.save
          render json: registration
        else
          render json: {"error": "could not create it"}
        end
      end

    end
  end
end
