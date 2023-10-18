require 'time'

require_relative 'perceptron_aas/version'
require_relative 'perceptron_aas/logger'
require_relative 'perceptron_aas/perceptron'

module PerceptronAas
  extend self

  def train(config, inputs, targets, iterations: 10)
    Perceptron.new(config).train(inputs, targets, iterations: iterations)
  end

  def step(config, inputs, targets)
    Perceptron.new(config).step(inputs, targets)
  end

  def predict(config, input)
    Perceptron.new(config).predict(input)
  end
end
