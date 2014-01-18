require 'itunes/library'

module LastfmItunes
  class Itunes
    attr_reader :library, :artist_tracks

    def initialize(xml_path)
      @library = ::ITunes::Library.load(xml_path)
      raise InvalidLibraryException unless library.track_ids
      @artist_tracks = group_tracks_by_artist
    end


    private

    def group_tracks_by_artist
      @library.music.tracks.each_with_object({}) do |track, hash|
        hash[track.artist] ||= []
        hash[track.artist] << track.name 
      end
    end
  end

  class InvalidLibraryException < Exception; end
end

