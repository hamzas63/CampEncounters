class AuthenticateUser
  include Interactor

  def call
    if context.a.user?
      redirect_to root_path, alert: 'You must be an admin to do that.'
    end
  end
end
