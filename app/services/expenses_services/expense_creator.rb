# frozen_string_literal: true

module ExpensesServices
  class ExpenseCreator < ApplicationService
    attr_accessor :user, :payment

    def initialize(user, payment)
      super()
      @user = user
      @payment = payment
    end

    # Creates an expense from a payment
    #
    # @param [Payments::Items::Payment] payment
    def call
      user.expenses.create!(
        concept: payment.statement_descriptor,
        subtotal_cents: payment.subtotal,
        total_cents: payment.total,
        currency: payment.currency,
        processor: payment.processor,
        processor_info: payment.processor_info
      )
    end
  end
end
