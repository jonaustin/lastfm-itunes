require 'spec_helper'

describe LastfmItunes::Lastfm do
  let(:lastfm) { LastfmItunes::Lastfm.new(lastfm_credentials) }

  it 'should find top tracks for artist' do
   VCR.use_cassette('lastfm top tracks') do
     top_tracks = lastfm.send(:artist_top_tracks, 'Radiohead')
     top_tracks.should be_an(Array)
     top_tracks.should include('Nude')
   end
  end

  it 'should return tracks that match those in given list' do
    VCR.use_cassette('lastfm top tracks') do
      lastfm.my_top_tracks('Radiohead', ['Nude']).should == ['Nude']
    end
  end
end
