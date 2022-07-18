# frozen_string_literal: true

class UsersController < AuthenticatedController
  skip_before_action :authenticate_request, only: [:create]

  DEFAULT_RETURN_TO = ENV.fetch('FRONTEND_URL')

  # POST /users
  def create
    user = User.create!(user_params)
    auth_token = AuthServices::UserAuthenticator.call(user.email, user.password)

    respond_auth_cookie(auth_token)
    redirect_to return_url, allow_other_host: true
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone)
  end

  def return_url
    params[:return_to_url] || DEFAULT_RETURN_TO
  end

  def respond_auth_cookie(auth_token)
    response.set_cookie(:auth_token,
                        {
                          value: auth_token,
                          expires: Time.zone.now + JsonWebToken::DEFAULT_TTL,
                          secure: Rails.env.production?,
                          httponly: true
                        })
  end
end
