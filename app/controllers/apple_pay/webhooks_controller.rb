# frozen_string_literal: true

module ApplePay
  # Controller dedicated to Apple Pay Webhooks
  # Same as Stripe::WebhooksController but for Apple Pay
  # Each processor may have its own verification method
  # so its better to have them on separates endpoints
  class WebhooksController < ApplicationController
    before_action :verify_hmac

    private

    def verify_hmac
      data = request.body.read
      hmac_header = request.headers['HTTP_X_APPLE_HMAC_SHA256']
      calculated_hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', API_SECRET_KEY, data))

      verified = ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac_header)
      return head :forbidden unless verified

      log_event
    end

    def log_event
      # Log webhook event
      # Log mechanism is up to you
      Rails.logger.info params.to_json
    end
  end
end
