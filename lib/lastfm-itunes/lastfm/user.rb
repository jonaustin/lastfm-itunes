module LastfmItunes::Lastfm
  class User
    include LastfmItunes::Tracks
    attr_accessor :user, :limit

    def initialize(args={})
      @user = ::Rockstar::User.new( args.fetch(:name) )
      @limit = args.fetch(:limit, 500)
    end

    def my_top_tracks(other_tracks)
      intersection_of_tracks(top_tracks, other_tracks)
    end

    def top_tracks
      user.top_tracks(false, @limit)
    end
  end
end
