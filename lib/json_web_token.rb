# frozen_string_literal: true

class JsonWebToken
  HMAC_ALG = 'HS256'
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  DEFAULT_TTL = 24.hours

  # Generates JWT from given payload
  #
  # @param [Hash] payload The payload to encode
  # @param [Hash] ttl Time to live for the token (seconds, days, etc)
  #
  # @return [String]
  def self.encode(payload, ttl: DEFAULT_TTL)
    payload[:exp] = (Time.zone.now + ttl).to_i
    JWT.encode(payload, HMAC_SECRET, HMAC_ALG)
  end

  # Decodes and verifies the given token
  # @param [String] jwt The JWT to decode
  #
  # @return [Hash] The decoded JWT payload
  def self.decode(token)
    JWT.decode(token, HMAC_SECRET).at(0).with_indifferent_access
  end
end
