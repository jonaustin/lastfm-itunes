require 'simplecov'
SimpleCov.start

# normal require does not work once gem is installed, because its loaded via rubygems
$:.unshift(File.expand_path('../lib', __FILE__))

require 'rspec'
require 'lastfm-itunes'

def itunes_xml_path
  Pathname.new(__FILE__).join('../', 'fixtures', 'iTunes Music Library.xml')
end

