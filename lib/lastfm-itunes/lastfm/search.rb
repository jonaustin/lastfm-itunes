require 'forwardable'
require 'delegate'

module LastfmItunes::Lastfm
  class Search < SimpleDelegator
    extend Forwardable
    delegate [:my_top_tracks, :top_tracks] => :@searcher

    def initialize(args)
      ::Rockstar.lastfm = args.fetch(:credentials)
      @searcher = args.fetch(:search_class, Artist).new(args)
    end
  end
end

