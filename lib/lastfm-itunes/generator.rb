require 'm3uzi'
require 'lastfm-itunes/patches/m3uzi'

module LastfmItunes
  class Generator
    attr_reader :m3u

    def initialize(m3u_path)
      @m3u              = ::M3Uzi.new
      @m3u.path         = m3u_path
    end

    def generate(tracks, &block)
      tracks.each { |t| @m3u.add_file(t) }
      @m3u.write @m3u.path
      @m3u
    end
  end
end
