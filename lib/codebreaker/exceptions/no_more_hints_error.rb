module Codebreaker
  module Exceptions
    class NoMoreHintsError < StandardError
      def message
        'No more hints'
      end
    end
  end
end
