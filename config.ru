gem 'sinatra', '1.4.6'
gem 'vcr', '3.0.1'

require 'rack'
require 'vcr'

$:.unshift File.expand_path('../lib', __FILE__)
require 'vaas'
require 'vaas/app'

VCR.configure do |c|
  c.cassette_library_dir = '/tmp'
end

app = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::ShowExceptions
  map "/_vaas" do
    run VAAS::App::API.new
  end
  run VAAS::App::Global.new
end

run app
