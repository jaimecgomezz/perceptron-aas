RSpec.describe PerceptronAas do
  let(:service) { PerceptronAas }

  # OR function
  let(:config) { { alpha: 0.1, dimension: 2, weights: [0.04339847, -0.05922528, 0.0282053] } }
  let(:inputs) { [[0, 0], [0, 1], [1, 0], [1, 1]] }
  let(:targets) { [0, 1, 1, 1] }

  describe '#train' do
    let(:result) { service.train(config, inputs, targets) }

    it 'returns updated Perceptron' do
      expect(result).to be_a(PerceptronAas::Perceptron)
    end
  end

  describe '#step' do
    let(:result) { service.step(config, inputs, targets) }

    it 'returns updated Perceptron' do
      expect(result).to be_a(PerceptronAas::Perceptron)
    end
  end

  describe '#predict' do
    let(:result) { service.predict(config, [0, 1]) }

    it 'returns prediction' do
      expect(result).to be_a(Integer)
    end
  end
end
