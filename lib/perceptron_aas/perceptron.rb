module PerceptronAas
  class Perceptron
    include Math
    include Logger

    attr_reader :inputs, :weights, :alpha

    def initialize(n_inputs, alpha: 0.001, weights: [])
      @n_inputs = n_inputs
      @alpha = alpha
      @weights = prepare_weights(weights, n_inputs)
    end

    def fit(trainings, targets, epochs: 10_000)
      weighted_trainings = trainings.map do |training|
        training + [1]
      end

      adjustments = 0
      epochs.times do
        weighted_trainings.zip(targets).each do |training, target|
          p = step(dot(training))

          if p != target
            error = p - target

            @weights = training.zip(weights).map do |t, w|
              w + (-alpha * error * t)
            end

            adjustments += 1

            debug("Weights adjusted: #{weights}")
          end
        end
      end

      info("Final weights: #{weights}. #{adjustments} were made.")

      self
    end

    def predict(inputs)
      step(dot(inputs))
    end

    private

    def step(x)
      x > 0 ? 1 : 0
    end

    def dot(training)
      result = 0

      training.zip(weights).each do |t, w|
        result += t * w
      end

      result
    end

    def prepare_weights(weights, n_inputs)
      return weights if weights.size == n_inputs

      weights = []
      (n_inputs + 1).times do
        weights << rand / sqrt(n_inputs)
      end

      info("Initial weights: #{weights}")

      weights
    end
  end
end
