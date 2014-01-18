require 'm3uzi'
require 'pathname'
require 'lastfm-itunes/itunes'
require 'lastfm-itunes/lastfm'
require 'lastfm-itunes/version'

module LastfmItunes
  class Generator
    attr_reader :m3u, :m3u_path

    def initialize(itunes_xml_path, lastfm_credentials, options={})
      @itunes_xml_path = itunes_xml_path
      @lastfm = Lastfm.new(lastfm_credentials)
      @m3u_path = options.fetch(:m3u_path) { default_m3u_path }
      @m3u = ::M3Uzi.new
    end

    def generate_m3u
      add_top_tracks_to_m3u
      @m3u.write @m3u_path
      @m3u
    end


    private

    def add_top_tracks_to_m3u
      fetch_top_tracks.each { |t| @m3u.add_file(t.location_path) }
    end

    def fetch_top_tracks
      top_tracks = []
      itunes_artist_tracks.each do |artist, tracks|
        top_tracks += lf_itunes_top_artist_tracks(artist, tracks)
      end
      top_tracks
    end

    def itunes_artist_tracks
      Itunes.new(@itunes_xml_path).artist_tracks
    end

    def lf_itunes_top_artist_tracks(artist, tracks)
      return [] if artist.nil? || tracks.empty?
      @lastfm.my_top_tracks(artist, tracks)
    end

    def default_m3u_path
      Pathname(@itunes_xml_path).dirname.join('Lastfm Top Tracks.m3u').to_s
    end
  end
end