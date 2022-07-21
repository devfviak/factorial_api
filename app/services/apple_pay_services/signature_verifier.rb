# frozen_string_literal: true

module ApplePayServices
  API_SECRET_KEY = 'blablabla'

  class SignatureVerifier < ApplicationService
    attr_reader :payload, :hmac

    def initialize(payload, hmac)
      super()
      @payload = payload
      @hmac = hmac
    end

    # Verifies the signature of the webhook request
    #
    # @return [Boolean] whether the signature is ok
    def call
      calculated_hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', API_SECRET_KEY, payload))
      ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac)
    end
  end
end
