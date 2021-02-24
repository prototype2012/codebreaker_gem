module Codebreaker
  module Exceptions
    class WrongDifficultyError < StandardError
      def message
        'Difficulty does not exist'
      end
    end
  end
end
