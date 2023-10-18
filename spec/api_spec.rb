RSpec.describe API do
  def app() = API

  let(:response) { last_response.body }
  let(:responsep) { JSON.parse(response) }

  before { header 'Content-Type', 'application/json' }

  describe '/train' do
    before do
      post(
        '/train',
        {
          inputs: [[0, 0], [0, 1], [1, 0], [1, 1]],
          targets: [0, 1, 1, 1],
          config: {
            alpha: 0.1,
            dimension: 2,
          },
        }.to_json
      )
    end

    it 'returns Perceptron configuration' do
      expect(response).to match_schema(:config)
    end
  end

  describe '/step' do
    before do
      post(
        '/step',
        {
          inputs: [[0, 0], [0, 1], [1, 0], [1, 1]],
          targets: [0, 1, 1, 1],
          config: {
            alpha: 0.1,
            dimension: 2,
          },
        }.to_json
      )
    end

    it 'returns Perceptron configuration' do
      expect(response).to match_schema(:config)
    end
  end

  describe '/predict' do
    before do
      post(
        '/predict',
        {
          input: [0, 0],
          config: {
            alpha: 0.1,
            dimension: 2,
            weights: [
              0.33164247365643884,
              0.10828168036675624,
              -0.09943160563927189,
            ],
          },
        }.to_json
      )
    end

    it 'returns prediction' do
      expect(response).to match_schema(:prediction)
    end
  end
end
