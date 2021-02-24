module Codebreaker
  module Validation
    def validate_name(name)
      trimmed_name = name.chomp.strip

      name_validation_rules = Constants::PLAYER_NAME_RULES.fetch(:length)

      raise Exceptions::NameValidationError if trimmed_name.length < name_validation_rules.fetch(:min)
      raise Exceptions::NameValidationError if trimmed_name.length > name_validation_rules.fetch(:max)

      name
    end

    def validate_difficulty(difficulty)
      raise Exceptions::WrongDifficultyError unless Constants::GAME_DIFFICULTY_CONFIG.key?(difficulty)

      difficulty
    end

    def validate_length(guess_array)
      raise Exceptions::EmptyArrayError, 'empty array' unless guess_array.length.positive?
      raise Exceptions::UnableToCompareError unless Constants::DIGITS_NUMBER == guess_array.length
    end

    def validate_range(guess_array)
      symbols_out_of_range = guess_array.reject do |symbol|
        (Constants::MIN_CODE_DIGIT..Constants::MAX_CODE_DIGIT).to_a.include? symbol
      end

      raise Exceptions::OutOfComparisonRangeError, symbols_out_of_range unless symbols_out_of_range.empty?
    end

    def validate_user_code(code)
      raise Exceptions::DigitsExpectedError unless code.scan(/\D/).empty?

      code
    end
  end
end
