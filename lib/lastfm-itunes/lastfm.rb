require 'rockstar'

module LastfmItunes
  class Lastfm
    def initialize(lastfm_credentials_hash)
      # {api_key: 'my_api_key', api_secret: 'my_api_secret'}
      Rockstar.lastfm = lastfm_credentials_hash
    end

    def my_top_tracks(artist, tracks)
      tracks & artist_top_tracks(artist)
    end

    private

    def artist_top_tracks(artist)
      artist = Rockstar::Artist.new(artist)
      artist.top_tracks.map(&:name)
    end
  end
end
