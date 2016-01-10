lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vaas/version'

Gem::Specification.new do |spec|
  spec.name          = "vaas"
  spec.version       = VAAS::VERSION
  spec.authors       = ["Derek Kastner"]
  spec.email         = ["dkastner@gmail.com"]
  spec.summary       = %q{VCR as a Service - a microservice for mocking services}
  spec.description   = %q{Record and play back interactions with external services, mock services}
  spec.homepage      = "http://github.com/dkastner/vaas"
  spec.license       = "MIT"
  spec.required_rubygems_version = '>=2.1'
  spec.files         = Dir['*.gemspec'] + Dir['*.md'] +
    ['Gemfile'] + Dir['lib/**/*.rb'] + Dir['spec/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'vcr', '3.0.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rack-test', '0.6.3'
  spec.add_development_dependency 'rake', '10.4.2'
  spec.add_development_dependency 'rspec', '3.4.0'
  spec.add_development_dependency 'sinatra', '1.4.6'
end
