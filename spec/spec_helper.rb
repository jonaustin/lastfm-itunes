require 'simplecov'
SimpleCov.start

# normal require does not work once gem is installed, because its loaded via rubygems
$:.unshift(File.expand_path('../lib', __FILE__))

require 'rspec'
require 'lastfm-itunes'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/fixtures/vcr'
  c.hook_into                :webmock
  c.ignore_localhost         = true
  c.default_cassette_options = { :record => :new_episodes }
  c.filter_sensitive_data('<API_KEY>') { ENV['LASTFM_API_KEY'] }
  c.filter_sensitive_data('<API_SECRET>') { ENV['LASTFM_API_SECRET'] }
end

RSpec.configure do |config|
  config.order = 'random'
end

def itunes_xml_path
  Pathname.new(__FILE__).join('../', 'fixtures', 'iTunes Music Library.xml')
end

def lastfm_credentials
  # If you regenerate the VCR fixtures you need to add your credentials to ENV!
  # http://www.last.fm/api/account/
  # e.g.:
  # export LASTFM_API_KEY='my_api_key'
  # export LASTFM_API_SECRET='my_api_secret'
  {
    api_key: ENV['LASTFM_API_KEY'],
    api_secret: ENV['LASTFM_API_SECRET']
  }
end

