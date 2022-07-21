# frozen_string_literal: true

module Stripe
  class MockController < AuthenticatedController
    # POST /api/v1/stripe/mock/checkout_completed
    def checkout_completed
      payment = stripe_helper.payment_info(checkout_session_mock)
      ExpensesServices::ExpenseCreator.call(@current_user, payment)

      head :ok
    end

    private

    def stripe_helper
      @stripe_helper ||= Payments::StripeProcessor::Helper.new
    end

    def checkout_session_mock
      {
        id: 'cs_test_a1LhKFH5h9MpH54YKn0B4eFaNDRSPOlbW5DmIR9RoJPFXfPa3cbV1LvwJa',
        statement_descriptor: 'TEST CHARGE',
        amount_subtotal: 999_999,
        amount_total: 999_999,
        client_reference_id: @current_user.id,
        currency: 'USD',
        discount: {
          coupon: { percent_off: 10.0 }
        }
      }
    end
  end
end
