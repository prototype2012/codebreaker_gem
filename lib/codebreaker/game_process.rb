module Codebreaker
  class GameProcess
    include ArrayComparator
    include Validation

    attr_reader :guess_code,
                :attempts_left

    def initialize(difficulty:, player_name:, secret_code:, **rest_params)
      validate_name(player_name)

      default_settings = Constants::GAME_DIFFICULTY_CONFIG.fetch(difficulty)
      attempts_info = rest_params[:attempts_info] || default_settings

      @secret_code = secret_code
      @difficulty = difficulty
      @player_name = player_name
      @attempts_left = attempts_info[:attempts_left] || default_settings.fetch(:attempts)
      @hints = init_hints(attempts_info[:hints])
      @guess_code = rest_params[:guess_code] || []
    end

    def win?
      @guess_code == @secret_code
    end

    def lose?
      !win? && @attempts_left.zero?
    end

    def init_hints(hints_info)
      hints_info.is_a?(Integer) ? @secret_code.shuffle.slice(0, hints_info) : hints_info
    end

    def hints_left
      @hints.length
    end

    def hint
      @hints.pop || raise(Exceptions::NoMoreHintsError)
    end

    def guess(guess_digits_array)
      raise Exceptions::NoMoreAttemptsError unless @attempts_left.positive?

      @guess_code = guess_digits_array

      @attempts_left -= 1

      compare(@secret_code, @guess_code)
    end

    def to_h
      default_settings = Constants::GAME_DIFFICULTY_CONFIG.fetch(@difficulty)

      {
        secret_code: @secret_code,
        guess_code: @guess_code,
        difficulty: @difficulty,
        player_name: @player_name,
        attempts_info: {
          attempts_total: default_settings[:attempts],
          hints_total: default_settings[:hints],
          attempts_left: @attempts_left,
          hints: @hints
        }
      }
    end
  end
end
