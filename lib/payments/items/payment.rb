# frozen_string_literal: true

module Payments
  module Items
    class Payment
      def to_h
        {
          statement_descriptor:,
          currency:,
          subtotal:,
          total:,
          discount:,
          processor:,
          processor_info:
        }.with_indifferent_access
      end

      def statement_descriptor
        raise 'Not implemented'
      end

      def currency
        raise 'Not implemented'
      end

      def subtotal
        raise 'Not implemented'
      end

      def total
        raise 'Not implemented'
      end

      def discount
        raise 'Not implemented'
      end

      def processor
        raise 'Not implemented'
      end

      def processor_info
        raise 'Not implemented'
      end
    end
  end
end
