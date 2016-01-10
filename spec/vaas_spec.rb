require 'spec_helper'

require "net/http"
require "uri"
require "yaml"

describe VAAS do
  let(:cassette_dir) { File.expand_path('../cassettes', __FILE__) }
  let(:uri) { URI.parse("http://#{ENV['VAAS_URL']}/hi") }

  it 'records an interaction with example.com and saves to a local directory' do
    VAAS.configure do |v|
      v.cassette_library_dir = cassette_dir
    end

    responses = VAAS.use_cassette :hi do
      [
        JSON.parse(Net::HTTP.get_response(uri)),
        JSON.parse(Net::HTTP.get_response(uri))
      ]
    end

    expect(responses).to eq [
      { 'hello' => 'world' },
      { 'hello' => 'world' }
    ]

    yaml = YAML::load_file(File.join(cassette_dir, 'hi.yml'))
    expect(yaml.length).to eq 1

    expect(yaml).to include({
      'foo' => 'boor'
    })
  end

end

