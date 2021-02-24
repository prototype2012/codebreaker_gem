RSpec.describe Codebreaker::ArrayComparator do
  let(:comparator) do
    Class.new.tap do |klass|
      klass.extend(described_class)
    end
  end

  it 'result should match' do
    [
      [[1, 2, 3, 5], [1, 2, 3, 5], '++++'],
      [[5, 5, 5, 5], [5, 5, 5, 5], '++++'],
      [[6, 6, 6, 1], [6, 6, 6, 1], '++++'],
      [[1, 2, 5, 3], [1, 2, 5, 2], '+++'],
      [[6, 1, 6, 3], [6, 1, 6, 4], '+++'],
      [[2, 2, 5, 6], [2, 2, 5, 2], '+++'],
      [[2, 2, 5, 6], [4, 2, 5, 6], '+++'],
      [[2, 2, 5, 6], [4, 2, 5, 5], '++'],
      [[2, 2, 5, 6], [2, 4, 4, 6], '++'],
      [[2, 2, 5, 6], [2, 1, 5, 1], '++'],
      [[2, 3, 3, 3], [2, 1, 1, 1], '+'],
      [[2, 3, 3, 3], [1, 3, 1, 1], '+'],
      [[2, 3, 3, 3], [1, 1, 3, 1], '+'],
      [[2, 3, 3, 3], [1, 1, 1, 3], '+'],
      [[2, 3, 3, 3], [6, 2, 3, 3], '++-'],
      [[6, 5, 4, 3], [2, 6, 6, 6], '-'],
      [[2, 6, 6, 6], [6, 5, 4, 3], '-'],
      [[6, 6, 2, 1], [3, 4, 6, 6], '--'],
      [[2, 3, 3, 3], [6, 3, 3, 2], '++-'],
      [[2, 3, 3, 3], [6, 6, 3, 2], '+-'],
      [[2, 3, 3, 3], [6, 2, 3, 6], '+-'],
      [[1, 2, 3, 4], [1, 3, 2, 6], '+--'],
      [[1, 2, 3, 4], [1, 6, 2, 3], '+--'],
      [[1, 2, 3, 4], [4, 2, 3, 5], '++-'],
      [[1, 2, 3, 4], [4, 3, 5, 5], '--'],
      [[1, 2, 3, 4], [3, 1, 2, 5], '---'],
      [[1, 2, 3, 4], [6, 1, 2, 3], '---'],
      [[1, 2, 3, 4], [4, 3, 1, 5], '---'],
      [[1, 2, 3, 4], [5, 1, 2, 3], '---'],
      [[1, 2, 3, 4], [4, 3, 2, 1], '----'],
      [[1, 2, 3, 4], [2, 3, 4, 1], '----'],
      [[1, 2, 3, 4], [4, 1, 2, 3], '----'],
      [[1, 2, 3, 4], [5, 5, 6, 6], ''],
      [[1, 2, 3, 3], [5, 5, 6, 4], ''],
      [[1, 2, 3, 4], [6, 5, 5, 6], '']
    ]
      .each { |code, guess, result| expect(comparator.compare(code, guess)).to eq(result) }
  end

  it 'exception should match' do
    [
      [[], [], Codebreaker::Exceptions::EmptyArrayError],
      [[1], [], Codebreaker::Exceptions::EmptyArrayError],
      [[], [2], Codebreaker::Exceptions::UnableToCompareError],
      [[1, 1, 2, 3], [1, Codebreaker::Constants::MAX_CODE_DIGIT + 1, 1, 2],
       Codebreaker::Exceptions::OutOfComparisonRangeError],
      [[2, 1, 2, 3], [2, Codebreaker::Constants::MIN_CODE_DIGIT - 1, 1, 2],
       Codebreaker::Exceptions::OutOfComparisonRangeError],
      [[1, 2, 3, 5], [5, 1, 'Z', 2], Codebreaker::Exceptions::OutOfComparisonRangeError],
      [[1, 2, 3, 4], [1, {}, 2, 4], Codebreaker::Exceptions::OutOfComparisonRangeError],
      [[1, 2, 3, 4], [1, nil, 2, 4], Codebreaker::Exceptions::OutOfComparisonRangeError],
      [[1, 2, 3, 6], [5, 1, 2, 3, 4], Codebreaker::Exceptions::UnableToCompareError],
      [[1, 2, 3, 4], [1, 2, 3], Codebreaker::Exceptions::UnableToCompareError]
    ]
      .each { |code, guess, error| expect { comparator.compare(code, guess) }.to raise_error(error) }
  end
end
