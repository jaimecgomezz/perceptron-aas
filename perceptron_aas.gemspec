require_relative 'lib/perceptron_aas/version'

Gem::Specification.new do |spec|
  spec.name = 'perceptron-aas'
  spec.version = PerceptronAas::VERSION
  spec.authors = ['jaimecgomezz']
  spec.email = ['work@jaimecgomezz.com']

  spec.summary = 'Train your Perceptron As a Service'
  spec.description = 'Perceptron AAS'
  spec.homepage = 'https://github.com/jaimecgomezz/perceptron-aas'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['allowed_push_host'] = 'https://github.com/jaimecgomezz/perceptron-aas'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select { |f| f.match(%r{lib/}) }
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'puma', '~> 6.4'
  spec.add_dependency 'sinatra', '~> 3.1'

  spec.add_development_dependency 'json-schema', '~> 4.1'
  spec.add_development_dependency 'pry', '~> 0.14.1'
  spec.add_development_dependency 'rack-contrib', '~> 2.3'
  spec.add_development_dependency 'rack-test', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'rubocop', '~> 1.25'
  spec.add_development_dependency 'rubocop-performance', '~> 1.13'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.8'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
end
