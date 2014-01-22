module LastfmItunes::Lastfm
  class Artist
    include LastfmItunes::Tracks
    attr_accessor :artist, :limit

    def initialize(args={})
      @artist = if args[:name]
                  ::Rockstar::Artist.new( args.fetch(:name) )
                else
                  nil
                end
      @limit = args.fetch(:limit, 50) # default number returned by lastfm
    end

    def my_top_tracks(other_tracks)
      found_tracks = []
      group_tracks_by_artist(other_tracks).each do |artist, tracks|
        next unless artist
        yield if block_given?
        @artist = Rockstar::Artist.new(artist)
        found_tracks.concat intersection_of_tracks(top_tracks, tracks)
      end
      found_tracks
    end

    def top_tracks
      artist.top_tracks
    end
  end
end
