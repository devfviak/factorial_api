# frozen_string_literal: true

module Payments
  module StripeProcessor
    class Helper
      # Extracts payment info from Stripe checkout session
      # @param [Stripe::CheckoutSession] checkout_session
      #
      # @return [Payments::Items::Payment] checkout_session
      def payment_info(checkout_session)
        StripeProcessor::Items::Payment.new(checkout_session)
      end
    end
  end
end
