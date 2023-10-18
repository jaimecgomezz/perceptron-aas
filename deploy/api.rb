require 'sinatra/base'
require 'rack/contrib'

require_relative '../lib/perceptron_aas'

class API < Sinatra::Base
  use Rack::JSONBodyParser

  set :environment, :production
  set :default_content_type, :json

  error do |err|
    status 500

    { error: err.message, backtrace: err.backtrace }.to_json
  end

  get('/healthcheck') { 204 }

  post('/train') do
    perceptron = PerceptronAas.train(
      params.fetch('config'),
      params.fetch('inputs'),
      params.fetch('targets')
    )

    { result: perceptron.config }.to_json
  end

  post('/step') do
    perceptron = PerceptronAas.step(
      params.fetch('config'),
      params.fetch('inputs'),
      params.fetch('targets')
    )

    { result: perceptron.config }.to_json
  end

  post('/predict') do
    prediction = PerceptronAas.predict(
      params.fetch('config'),
      params.fetch('input'),
    )

    { result: prediction }.to_json
  end
end
