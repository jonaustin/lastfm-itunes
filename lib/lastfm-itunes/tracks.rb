module LastfmItunes
  module Tracks
    #
    # Tracks are expected to be of type Array (or mix in Enumerable)
    # A singular track is expected to respond to .name and .artist
    #

    def intersection_of_tracks(tracks, other_tracks)
      tracks.each_with_object([]) do |track, found_tracks|
        found_tracks.concat find(track, other_tracks)
        return found_tracks if over_limit?(found_tracks)
      end
    end

    def find(track, tracks)
      tracks.select do |t|
        t.name.downcase == track.name.downcase \
          && t.artist.downcase == track.artist.downcase
      end
    end

    def over_limit?(tracks)
      return false unless @limit
      tracks.size >= @limit
    end

    def group_tracks_by_artist(tracks)
     tracks.each_with_object({}) do |track, hash|
        hash[track.artist] ||= []
        hash[track.artist] << track
      end
    end
  end
end

