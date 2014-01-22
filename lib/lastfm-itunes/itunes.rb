require 'itunes/library'

module LastfmItunes
  class Itunes
    include Tracks
    attr_accessor :library, :tracks, :xml_path

    def initialize(xml_path)
      @xml_path = File.expand_path(xml_path)
      @library = ::ITunes::Library.load(@xml_path)
      raise InvalidLibraryException unless library.track_ids
      @tracks = @library.music.tracks.select { |t| t.location_path }
    end

    alias :old_group_tracks_by_artist :group_tracks_by_artist
    def group_tracks_by_artist
      old_group_tracks_by_artist(@tracks)
    end

    def artists
      @tracks.map(&:artist)
    end
  end

  class InvalidLibraryException < Exception; end
end

