# frozen_string_literal: true

module Stripe
  # Controller dedicated to Stripe Webhooks
  # This base controller takes care of verifying the singature
  # Other stripe controllers must inherit from it
  #
  # In our test application this won't be used as stripe payments are being mocked
  # but this gives you and idea of how it would be implemented
  class WebhooksController < ApplicationController
    private

    # Verify webhook signature and construcsts event
    # @param [String] webhook_secret
    def construct_event(webhook_secret)
      payload = request.body.read
      signature = request.env['HTTP_STRIPE_SIGNATURE']

      event = StripeServices::SignatureVerifier.call(payload, signature, webhook_secret)
      return head :forbidden unless event

      log_event(event)
      event[:data][:object]
    end

    def log_event(event)
      # Log webhook event
      # Log mechanism is up to you
      Rails.logger.info event.to_json
    end
  end
end
