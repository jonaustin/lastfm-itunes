require 'rockstar'

module LastfmItunes
  class Lastfm
    def initialize(lastfm_credentials_hash)
      # {api_key: 'my_api_key', api_secret: 'my_api_secret'}
      Rockstar.lastfm = lastfm_credentials_hash
    end

    def my_top_tracks(artist, tracks, limit=nil)
      return [] if artist.nil? || tracks.empty?
      tracks_by_name = index_by_name(tracks)
      limit ||= tracks_by_name.size
      artist_top_tracks(artist).each_with_object([]) do |lft, array|
        array << tracks_by_name[lft.downcase] if tracks_by_name[lft.downcase]
       return array if array.size >= limit
      end
    end

    private

    def index_by_name(tracks)
      tracks.each_with_object({}) { |t, hash| hash[t.name.downcase] = t }
    end

    def artist_top_tracks(artist)
      artist = Rockstar::Artist.new(artist)
      artist.top_tracks.map(&:name)
    end
  end
end
