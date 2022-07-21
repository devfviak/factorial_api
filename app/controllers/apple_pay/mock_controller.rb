# frozen_string_literal: true

module ApplePay
  class MockController < AuthenticatedController
    # POST /api/v1/apple_pay/mock/payment_completed
    def payment_completed
      payment = apple_pay_helper.payment_info(apple_payment_mock)
      ExpensesServices::ExpenseCreator.call(@current_user, payment)

      head :ok
    end

    private

    def apple_pay_helper
      @apple_pay_helper ||= Payments::ApplePayProcessor::Helper.new
    end

    def apple_payment_mock
      {
        payment_id: 'pay_123432',
        description: 'TEST CHARGE',
        amount:
        {
          before_taxes: 100.0,
          after_taxes: 121.0
        },
        currency_code: 'USD',
        percent_off: 10.0
      }
    end
  end
end
