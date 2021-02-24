module Codebreaker
  module Exceptions
    class NoMoreAttemptsError < StandardError
      def message
        'No more attempts'
      end
    end
  end
end
