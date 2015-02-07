require 'spec_helper'

describe LastfmItunes::Playlist do
  let(:default_args) do
    {
      name: 'Radiohead',
      itunes_xml_path: itunes_xml_path,
      credentials: lastfm_credentials
    }
  end
  let(:playlist) { LastfmItunes::Playlist.new(default_args) }

  context 'playlist of tracks that are available in both itunes and lastfm' do
    it 'should find all if no limit given' do
      VCR.use_cassette('lastfm top tracks for all itunes artists') do
        playlist.fetch_tracks
        playlist.tracks.size.should == 81
      end
    end

    it 'should respect limit for number of each artist tracks to return' do
      VCR.use_cassette('lastfm top tracks for all itunes artists with limit') do
        playlist_with_limit = described_class.new(default_args.merge(limit: 1))
        playlist_with_limit.fetch_tracks
        playlist_with_limit.tracks.size.should == 13
      end
    end
  end
end
