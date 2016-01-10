$:.unshift File.expand_path('../../app', __FILE__)

require 'vaas/api'
require 'vaas/archive'
require 'vaas/configuration'

module VAAS

  def self.use_cassette(name, options = {}, &blk)
    API.configure Configuration
    API.lend_cassette Archive.find_cassette(name)
    API.insert_cassette name, options
    result = blk.call
    API.eject_cassette name
    Archive.store_cassette API.return_cassette(name)

    result
  end

end
