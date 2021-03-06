class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :authenticate_user!

  def index; end

  private

  def authorize_admin
    return if current_user.admin?

    redirect_to root_path, alert: 'You must be an admin to do that.'
  end
end
