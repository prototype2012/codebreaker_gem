module Codebreaker
  module Exceptions
    class DigitsExpectedError < StandardError
      def message
        'only digit expected, got various characters'
      end
    end
  end
end
