RSpec.describe Codebreaker::CodeGenerator do
  context 'when code successfully generated' do
    let(:config) do
      {
        digits_number: 5,
        min_code_digit: 1,
        max_code_digit: 7
      }
    end

    let(:generated_code) { described_class.generate(config) }

    it 'arrays with expected length' do
      expect(generated_code.length).to eq(config[:digits_number])
    end

    it 'each symbol should be between range' do
      generated_code.all? do |digit|
        expect(digit).to be_between(config[:min_code_digit], config[:max_code_digit])
      end
    end
  end
end
