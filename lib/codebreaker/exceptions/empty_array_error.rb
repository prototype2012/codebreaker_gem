module Codebreaker
  module Exceptions
    class EmptyArrayError < StandardError
      def message
        'Unable to compare empty arrays'
      end
    end
  end
end
