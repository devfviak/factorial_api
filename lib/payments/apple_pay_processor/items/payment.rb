# frozen_string_literal: true

module Payments
  module ApplePayProcessor
    module Items
      class Payment < Payments::Items::Payment
        include Constants

        def initialize(payment_result)
          super()
          @payment_result = payment_result.with_indifferent_access
        end

        def statement_descriptor
          @payment_result[:description]
        end

        def currency
          @payment_result[:currency_code]
        end

        def subtotal
          (@payment_result.dig(:amount, :before_taxes) * 100).to_i
        end

        def total
          (@payment_result.dig(:amount, :after_taxes) * 100).to_i
        end

        def discount
          return nil if @payment_result[:percent_off].blank?

          Discount.new(@payment_result[:percent_off]).to_h
        end

        def processor
          PROCESSOR_ID
        end

        def processor_info
          {
            apple_pay_payment_id: @payment_result[:payment_id]
          }
        end
      end
    end
  end
end
