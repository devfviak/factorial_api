# frozen_string_literal: true

module Payments
  module StripeProcessor
    module Items
      class Payment < Payments::Items::Payment
        include Constants

        def initialize(checkout_session)
          super()
          @checkout_session = checkout_session
        end

        def statement_descriptor
          @checkout_session[:statement_descriptor]
        end

        def currency
          @checkout_session[:currency]
        end

        def subtotal
          @checkout_session[:amount_subtotal]
        end

        def total
          @checkout_session[:amount_total]
        end

        def discount
          return nil if @checkout_session[:discount].blank?

          Discount.new(@checkout_session[:discount]).to_h
        end

        def processor
          PROCESSOR_ID
        end

        def processor_info
          {
            checkout_session_id: @checkout_session[:id]
          }
        end
      end
    end
  end
end
