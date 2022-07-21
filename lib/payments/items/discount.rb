# frozen_string_literal: true

module Payments
  module Items
    class Discount
      def to_h
        {
          percent_off:,
          amount_off:
        }.compact.with_indifferent_access
      end

      def percent_off
        raise 'Not implemented'
      end

      def amount_off
        raise 'Not implemented'
      end
    end
  end
end
