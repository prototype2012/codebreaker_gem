module Codebreaker
  module Exceptions
    class NegativeNumberError < StandardError
      def message
        'Should be positive'
      end
    end
  end
end
