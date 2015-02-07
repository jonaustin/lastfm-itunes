require 'simplecov'
SimpleCov.start

# normal require does not work once gem is installed, because its loaded via rubygems
$:.unshift(File.expand_path('../lib', __FILE__))

require 'rspec'
require 'lastfm-itunes'
require 'vcr'

VCR.configure do |c|
  c.hook_into                  :webmock
  c.cassette_library_dir     = 'spec/fixtures/vcr'
  c.ignore_localhost         = true
  c.filter_sensitive_data('API_KEY')    { ENV['LASTFM_API_KEY'] }
  c.filter_sensitive_data('API_SECRET') { ENV['LASTFM_API_SECRET'] }
  c.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:method,
      VCR.request_matchers.uri_without_param(:api_key)]
  }
end

RSpec.configure do |config|
  config.order = 'random'
end

def itunes_xml_path
  Pathname.new(__FILE__).join('..', 'fixtures', 'iTunes Music Library.xml')
end

def itunes_remote_xml_path
  Pathname.new(__FILE__).join('..', 'fixtures', 'iTunes Music Library Remote.xml')
end

def lastfm_credentials
  # If you regenerate the VCR fixtures you need to add your credentials to ENV!
  # http://www.last.fm/api/account/
  # e.g.:
  # export LASTFM_API_KEY='my_api_key'
  # export LASTFM_API_SECRET='my_api_secret'
  key =    ENV['LASTFM_API_KEY']
  secret = ENV['LASTFM_API_SECRET']

  if key.nil? || secret.nil?
    raise LastfmItunes::InvalidConfigException, \
      'LASTFM_KEY and LASTFM_SECRET environment variables must be set'
  end

  {
    api_key:    key,
    api_secret: secret
  }
end

class LastfmItunes::InvalidConfigException < Exception; end
