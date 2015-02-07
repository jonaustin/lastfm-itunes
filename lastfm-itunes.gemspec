# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lastfm-itunes/version'

Gem::Specification.new do |spec|
  spec.name          = 'lastfm-itunes'
  spec.version       = LastfmItunes::VERSION
  spec.authors       = ['Jon Austin']
  spec.email         = ['jon.i.austin@gmail.com']
  spec.summary       = %q{CLI tool to easily create m3u playlists of top Lastfm tracks from an iTunes library}
  spec.description   = %q{Easily create playlists of top Lastfm tracks from your iTunes library.}
  spec.homepage      = 'https://github.com/jonaustin/lastfm-itunes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rockstar',                '~> 0.8'
  spec.add_dependency 'rainbow',                 '~> 2.0'
  spec.add_dependency 'm3uzi',                   '~> 0.5'
  spec.add_dependency 'highline',                '~> 1.6'
  spec.add_dependency 'ruby-progressbar',        '~> 1.7'
  spec.add_dependency 'andyw8-itunes-library',   '~> 0.1' # original does not have track.location* methods

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler',      '~> 1.7'
  spec.add_development_dependency 'rspec',        '~> 2.14.1'
  spec.add_development_dependency 'simplecov',    '~> 0.9'
  spec.add_development_dependency 'pry-byebug',   '~> 3.0'
  spec.add_development_dependency 'vcr',          '~> 2.9'
  spec.add_development_dependency 'webmock',      '~> 1.20'
end
