module Codebreaker
  module Exceptions
    class OutOfComparisonRangeError < StandardError
      def message
        'There are characters that are out of comparison range'
      end
    end
  end
end
