require_relative 'api'

run Rack::URLMap.new('/' => API)
