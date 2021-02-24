RSpec.describe Codebreaker::GameProcess do
  context 'when works correctly' do
    subject(:game_process) { described_class.new(config.clone) }

    let(:secret_code) { [1, 2, 3, 3] }
    let(:wrong_code) { [5, 4, 3, 1] }
    let(:config) do
      { player_name: 'boris',
        difficulty: :easy,
        secret_code: secret_code,
        attempts_info: {
          hints: [2, 3],
          attempts_left: 2
        } }
    end

    let(:code_generator_config) do
      {
        digits_number: 4,
        min_code_digit: 1,
        max_code_digit: 6
      }
    end

    it 'attempts number is correct before start' do
      expect(game_process.attempts_left).to be(config[:attempts_info][:attempts_left])
    end

    it 'hint works fine' do
      expect(secret_code).to include(game_process.hint)
    end

    it 'hing should be allowed according to config times' do
      game_process.instance_variable_get(:@hints).length.times do
        expect(secret_code).to include(game_process.hint)
      end
    end

    it 'hints number is correct before start' do
      expect(game_process.instance_variable_get(:@hints).length)
        .to be(config[:attempts_info][:hints].length)
    end

    it 'hints are being decreased when playing' do
      hints_before = config[:attempts_info][:hints].length
      game_process.hint

      expect(game_process.instance_variable_get(:@hints).length)
        .to be(hints_before - 1)
    end

    it 'hints left should have correct value' do
      expect(game_process.hints_left).to be(config[:attempts_info][:hints].length)
    end

    it 'possible to win' do
      game_process.guess(secret_code)

      expect(game_process.win?).to eq(true)
    end

    it 'attempts are being decreased when playing' do
      attempts_before = config[:attempts_info][:attempts_left]
      game_process.guess(wrong_code)

      expect(game_process.attempts_left).to eq(attempts_before - 1)
    end

    it 'serializes correctly' do
      expect(game_process.to_h).to eq(config.merge({
                                                     attempts_info: { attempts_left: 2,
                                                                      attempts_total: 15,
                                                                      hints: [2, 3],
                                                                      hints_total: 2 },
                                                     guess_code: []
                                                   }))
    end

    it 'game can be recovered from hash' do
      serialized_game = game_process.to_h

      expect(described_class.new(serialized_game).to_h)
        .to eq(serialized_game)
    end

    it 'not changes lose if some attempts left' do
      game_process.instance_variable_set(:@attempts_left, 1)

      expect(game_process.lose?).to eq(false)
    end

    it 'changes lose to true after using all attempts' do
      game_process.instance_variable_set(:@attempts_left, 0)

      expect(game_process.lose?).to eq(true)
    end
  end

  context 'when raises error' do
    subject(:game_process) { described_class.new(config) }

    let(:secret_code) { [1, 2, 3, 3] }
    let(:wrong_code) { [5, 4, 3, 1] }
    let(:code_generator_config) do
      {
        digits_number: 4,
        min_code_digit: 1,
        max_code_digit: 6
      }
    end

    let(:config) do
      {
        player_name: 'boris',
        difficulty: :easy,
        secret_code: secret_code,
        attempts_info: {
          hints: [1, 3],
          attempts_left: 1
        }
      }
    end

    it 'hinting more than allowed raises error' do
      game_process.instance_variable_set(:@hints, [])

      expect { game_process.hint }.to raise_error(Codebreaker::Exceptions::NoMoreHintsError)
    end

    it 'guessing more than allowed raises error' do
      game_process.instance_variable_set(:@attempts_left, 0)

      expect { game_process.guess(wrong_code) }.to raise_error(Codebreaker::Exceptions::NoMoreAttemptsError)
    end
  end
end
