module LastfmItunes
  class Playlist
    attr_reader :tracks, :itunes
    attr_accessor :limit

    def initialize(args)
      @search = Lastfm::Search.new(
        credentials: args.fetch(:credentials),
        search_class: args.fetch(:search_class, LastfmItunes::Lastfm::Artist),
        name:   args.fetch(:name, nil),
        limit:  args.fetch(:limit, nil))
      @itunes = Itunes.new args.fetch(:itunes_xml_path)
      @tracks = []
    end

    def fetch_tracks(&block)
      @tracks = @search.my_top_tracks(@itunes.tracks,
                                      &block)
    end

    def track_paths
      @tracks.map { |t| t.location_path }
    end
  end
end
