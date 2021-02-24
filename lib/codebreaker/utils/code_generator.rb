module Codebreaker
  module CodeGenerator
    class << self
      def generate(digits_number:, min_code_digit:, max_code_digit:)
        Array.new(digits_number) { rand(min_code_digit..max_code_digit) }
      end

      def generate_by_defaults
        generate({ digits_number: Constants::DIGITS_NUMBER,
                   min_code_digit: Constants::MIN_CODE_DIGIT,
                   max_code_digit: Constants::MAX_CODE_DIGIT })
      end
    end
  end
end
