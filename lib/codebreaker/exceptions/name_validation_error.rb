module Codebreaker
  module Exceptions
    class NameValidationError < StandardError
      def message
        validation_rules = Codebreaker::Constants::PLAYER_NAME_RULES[:length]
        "Player name length should be between #{validation_rules[:min]} and #{validation_rules[:max]}"
      end
    end
  end
end
