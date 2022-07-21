# frozen_string_literal: true

module Payments
  module StripeProcessor
    module Items
      class Discount < Payments::Items::Discount
        def initialize(discount)
          super()
          @coupon = discount[:coupon]
        end

        def percent_off
          @coupon[:percent_off].to_f
        end

        def amount_off
          @coupon[:amount_off].to_f
        end
      end
    end
  end
end
