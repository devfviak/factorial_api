# frozen_string_literal: true

module AuthServices
  class RequestAuthenticator < ApplicationService
    include Exceptions

    attr_reader :headers

    def initialize(headers)
      super()
      @headers = headers
    end

    def call
      token = token_from_headers

      decoded_payload = JsonWebToken.decode(token)
      user_id = decoded_payload[:user_id]

      User.find(user_id)
    rescue JWT::ExpiredSignature
      raise ExpiredToken
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      raise InvalidToken
    end

    private

    def token_from_headers
      token = @headers['Authorization']
      raise MissingToken unless token

      token
    end
  end
end
