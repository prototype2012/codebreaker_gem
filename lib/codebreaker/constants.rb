module Codebreaker
  module Constants
    MIN_CODE_DIGIT = 1
    MAX_CODE_DIGIT = 6
    DIGITS_NUMBER = 4

    PLAYER_NAME_RULES = {
      length: {
        min: 3,
        max: 20
      }
    }.freeze

    CORRECT_DIGIT_SIGN = '+'.freeze

    INCORRECT_POSITION_SIGN = '-'.freeze

    GAME_DIFFICULTY_CONFIG = {
      easy: {
        attempts: 15,
        hints: 2
      },
      medium: {
        attempts: 10,
        hints: 1
      },
      hell: {
        attempts: 5,
        hints: 1
      }
    }.freeze
  end
end
