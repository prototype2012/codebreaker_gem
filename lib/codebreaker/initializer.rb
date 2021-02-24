require 'bundler/setup'
require 'codebreaker'

require_relative './constants'

require_relative './exceptions/negative_number_error'
require_relative './exceptions/out_of_comparison_range_error'
require_relative './exceptions/empty_array_error'
require_relative './exceptions/unable_to_compare_error'
require_relative './exceptions/number_expected_error'
require_relative './exceptions/no_more_attempts_error'
require_relative './exceptions/no_more_hints_error'
require_relative './exceptions/name_validation_error'
require_relative './exceptions/wrong_difficulty_error'
require_relative './exceptions/digit_expected_error'

require_relative './validation/validation'

require_relative './utils/array_comparator'
require_relative './utils/code_generator'

require_relative './game_process'
