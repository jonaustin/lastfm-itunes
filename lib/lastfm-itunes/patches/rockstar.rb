module Rockstar
  # Lastfm supports a limit, but rockstar currently does not
  # This simply adds the limit parameter
  class User < Base
    def top_tracks(force=false, limit = 50)
      get_instance("user.getTopTracks", :top_tracks, :track, {:user => @username, :limit => limit}, force)
    end
  end
end
