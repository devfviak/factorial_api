# frozen_string_literal: true

module CookieHandler
  def configure_auth_cookie(auth_token)
    response.set_cookie(:auth_token,
                        {
                          value: auth_token,
                          expires: Time.zone.now + JsonWebToken::DEFAULT_TTL,
                          secure: Rails.env.production?,
                          path: '/',
                          httponly: true
                        })
  end
end
