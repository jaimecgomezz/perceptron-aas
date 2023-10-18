RSpec.describe PerceptronAas::Perceptron do
  let(:perceptron) { PerceptronAas::Perceptron.new({ alpha: 0.1, dimension: 2 }) }

  describe '#train' do
    describe 'OR' do
      let(:trained) { perceptron.train([[0, 0], [0, 1], [1, 0], [1, 1]], [0, 1, 1, 1]) }

      it 'correctly classsifies' do
        expect(trained.predict([0, 0])).to eq(0)
        expect(trained.predict([0, 1])).to eq(1)
        expect(trained.predict([1, 0])).to eq(1)
        expect(trained.predict([1, 1])).to eq(1)
      end
    end

    describe 'AND' do
      let(:trained) { perceptron.train([[0, 0], [0, 1], [1, 0], [1, 1]], [0, 0, 0, 1]) }

      it 'handles classsifies' do
        expect(trained.predict([0, 0])).to eq(0)
        expect(trained.predict([0, 1])).to eq(0)
        expect(trained.predict([1, 0])).to eq(0)
        expect(trained.predict([1, 1])).to eq(1)
      end
    end
  end

  describe '#step' do
    let(:stepped) { perceptron.step([[0, 0], [0, 1], [1, 0], [1, 1]], [0, 1, 1, 1]) }

    it 'returns update Perceptron' do
      expect(stepped).to be_a(PerceptronAas::Perceptron)
    end
  end

  describe '#predict' do
    let(:prediction) { perceptron.predict([0, 1]) }

    it 'returns a prediction' do
      expect(prediction).to be_a(Integer)
    end
  end
end
