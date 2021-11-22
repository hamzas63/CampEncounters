class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :authenticate_user!

  def index; end

  private

  def authorize_admin
    if current_user.user?
      redirect_to root_path, alert: 'You must be an admin to do that.'
    end
  end
end
