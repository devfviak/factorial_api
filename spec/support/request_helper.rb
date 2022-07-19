# frozen_string_literal: true

module RequestHelper
  def token_generator(user_id)
    ::JsonWebToken.encode({ user_id: })
  end

  def expired_token_generator(user_id)
    ::JsonWebToken.encode({ user_id: }, ttl: -1.second)
  end

  def configure_auth_cookie(user_id)
    cookies['auth_token'] = token_generator(user_id)
  end
end
