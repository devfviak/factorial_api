# frozen_string_literal: true

module Stripe
  class PaymentsController < Stripe::WebhooksController
    CHECKOUT_COMPLETED_SUCCEDED_WH_SECRET = 'TEST'
    # Rails.application.credentials.stripe('CHECKOUT_COMPLETED_WH_SECRET')

    # POST /api/v1/stripe/payments/checkout_completed
    # Payment is successful and checkout is completed
    def checkout_completed
      checkout_session = construct_event(CHECKOUT_COMPLETED_SUCCEDED_WH_SECRET)
      user = User.find_by(checkout_session[:client_reference_id])

      payment = stripe_helper.payment_info(checkout_session)

      ExpensesServices::ExpenseCreator.call(user, payment)
      head :ok
    end

    private

    def stripe_helper
      @stripe_helper ||= Payments::StripeProcessor::Helper.new
    end
  end
end
