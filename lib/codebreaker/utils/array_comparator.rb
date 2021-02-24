module Codebreaker
  module ArrayComparator
    include Validation

    def compare(code, guess)
      validate_length(guess)
      validate_range(guess)

      matches = count_matches(code, guess)
      mismatches = count_mismatches(code, guess)

      Constants::CORRECT_DIGIT_SIGN * matches +
        Constants::INCORRECT_POSITION_SIGN * mismatches
    end

    private

    def count_matches(code, guess)
      code
        .zip(guess)
        .count { |code_digit, guess_digit| code_digit == guess_digit }
    end

    def count_mismatches(code, guess)
      code_array, guess_array  = filter_matches(code, guess)

      return 0 if code_array.nil?

      guess_array.count do |digit|
        digit_index = code_array.find_index(digit)
        code_array.delete_at(digit_index) if code_array.find_index(digit)
        !digit_index.nil?
      end
    end

    def filter_matches(code, guess)
      code
        .zip(guess)
        .reject { |code_digit, guess_digit| code_digit == guess_digit }
        .transpose
    end
  end
end
