json.extract! user, :id, :first_name, :last_name, :middle_name, :phone, :country, :terms_of_service, :email, :type, :password, :password_confirmation, :created_at, :updated_at
json.url user_url(user, format: :json)
