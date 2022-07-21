# frozen_string_literal: true

module Payments
  module ApplePayProcessor
    module Items
      class Discount < Payments::Items::Discount
        # Create a new Discount item
        # @param [Integer] perc_off Apple Pay payment object
        def initialize(perc_off)
          super()
          @perc_off = perc_off
        end

        def percent_off
          @perc_off.to_f
        end

        def amount_off
          nil
        end
      end
    end
  end
end
