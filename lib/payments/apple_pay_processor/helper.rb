# frozen_string_literal: true

module Payments
  module ApplePayProcessor
    class Helper
      # Extracts payment info from Apple Pay completed paytment
      # @param [ApplePay::Payment] apple_payment
      #
      # @return [Payments::Items::Payment] payment
      def payment_info(apple_payment)
        StripeProcessor::Items::Payment.new(apple_payment)
      end
    end
  end
end
