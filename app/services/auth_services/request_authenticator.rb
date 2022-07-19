# frozen_string_literal: true

module AuthServices
  class RequestAuthenticator < ApplicationService
    include Exceptions

    attr_reader :auth_token

    def initialize(auth_token)
      super()
      @auth_token = auth_token
    end

    def call
      decoded_payload = JsonWebToken.decode(auth_token)
      user_id = decoded_payload[:user_id]

      User.find(user_id)
    rescue JWT::ExpiredSignature
      raise ExpiredToken
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      raise InvalidToken
    end
  end
end
