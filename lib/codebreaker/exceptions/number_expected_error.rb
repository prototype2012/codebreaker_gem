module Codebreaker
  module Exceptions
    class NumberExpectedError < StandardError
      def message
        'value expected to be a number'
      end
    end
  end
end
