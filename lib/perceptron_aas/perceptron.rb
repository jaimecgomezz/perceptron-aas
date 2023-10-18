module PerceptronAas
  class Perceptron
    include Math
    include Logger

    attr_reader :dimension, :weights, :alpha

    def initialize(config)
      @dimension = config.fetch(:dimension)
      @alpha = config.fetch(:alpha, 0.1)
      @weights = prepare_weights(config.fetch(:weights, []), dimension)
    end

    def config
      { dimension: dimension, alpha: alpha, weights: weights }
    end

    def train(inputs, targets, iterations: 100)
      iterations.times do
        step(inputs, targets)
      end

      info("Final weights: #{weights}")

      self
    end

    def step(inputs, targets)
      weighted_inputs = inputs.map do |input|
        input + [1]
      end

      weighted_inputs.zip(targets).each do |input, target|
        prediction = _predict(input)

        if prediction != target
          error = prediction - target

          @weights = input.zip(weights).map do |i, w|
            w + (-alpha * error * i)
          end

          debug("Weights adjusted: #{weights}")
        end
      end

      self
    end

    def predict(input)
      input << 1

      _predict(input)
    end

    private

    def _predict(input)
      result = 0

      input.zip(weights).each do |i, w|
        result += i * w
      end

      result > 0 ? 1 : 0
    end

    def prepare_weights(ws, dimension)
      if ws.size != (dimension + 1)
        ws = []

        (dimension + 1).times do
          ws << rand / sqrt(dimension)
        end
      end

      info("Initial weights: #{ws}")

      ws
    end
  end
end
