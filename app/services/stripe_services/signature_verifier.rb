# frozen_string_literal: true

module StripeServices
  class SignatureVerifier < ApplicationService
    attr_reader :payload, :signature, :wh_secret

    def initialize(payload, sig_header, wh_secret)
      super()
      @payload = payload
      @sig_header = sig_header
      @wh_secret = wh_secret
    end

    # Verifies the signature of the webhook request
    #
    # @return [Hash] The webhook event if successful, nil otherwise
    def call
      Stripe::Webhook.construct_event(
        payload, sig_header, webhook_secret
      )
    rescue Stripe::SignatureVerificationError
      nil
    end
  end
end
