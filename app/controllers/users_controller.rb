# frozen_string_literal: true

class UsersController < AuthenticatedController
  include CookieHandler

  skip_before_action :authenticate_request, only: %i[create sign_in]

  DEFAULT_RETURN_TO = ENV.fetch('FRONTEND_URL')

  # GET /users/me
  def show
    json_response(@current_user)
  end

  # POST /users
  def create
    user = User.create!(user_params)
    authenticate_user(user.email, user.password)

    redirect_to return_url, allow_other_host: true
  end

  # POST /users/sign_in
  def sign_in
    email, password = params.require(%i[email password])
    authenticate_user(email, password)

    head :ok
  end

  # PUT/PATCH /users
  def update
    @current_user.update!(user_params)
    json_response(@current_user)
  end

  # DELETE /users
  def destroy
    @current_user.destroy!
    response.set_cookie(:auth_token, { value: '', expires: Time.zone.now - 1 })
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
  end

  def authenticate_user(email, password)
    auth_token = AuthServices::UserAuthenticator.call(email, password)
    configure_auth_cookie(auth_token)
  end

  def return_url
    params[:return_to_url] || DEFAULT_RETURN_TO
  end
end
