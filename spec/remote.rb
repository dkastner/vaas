require 'bundler/setup'

require 'json'
require 'sinatra'

set :port, 80

get '/hi' do
  content_type :json

  { hello: 'world' }.to_json
end
