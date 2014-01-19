require 'spec_helper'
require 'ostruct'

describe LastfmItunes::Lastfm do
  let(:lastfm) { LastfmItunes::Lastfm.new(lastfm_credentials) }
  let(:track) { OpenStruct.new(name: 'Nude') }
  let(:more_popular_track) { OpenStruct.new(name: 'Creep') }

  context 'my_top_tracks' do
    it "should return matching tracks in lastfm's order" do
      VCR.use_cassette('lastfm top tracks') do
        lastfm.my_top_tracks('Radiohead', [track, more_popular_track]).should == [more_popular_track, track]
      end
    end

    it 'should ignore differences in case' do
      VCR.use_cassette('lastfm top tracks') do
        messed_case_track = OpenStruct.new(name: 'cReeP')
        lastfm.my_top_tracks('Radiohead', [messed_case_track]).should == [messed_case_track]
      end
    end

    it 'should respect limit' do
      VCR.use_cassette('lastfm top tracks') do
        lastfm.my_top_tracks('Radiohead', [track, more_popular_track], 1).should == [more_popular_track]
      end
    end

    context 'if no artist given' do
      it 'should return empty result and not query lastfm' do
        lastfm.should_not_receive(:artist_top_tracks)
        lastfm.my_top_tracks(nil, [track]).should == []
      end
    end

    context 'if no tracks given' do
      it 'should return empty result and not query lastfm' do
        lastfm.should_not_receive(:artist_top_tracks)
        lastfm.my_top_tracks('Radiohead', []).should == []
      end
    end
  end

  context 'artist_top_tracks' do
    it 'should find top tracks for artist' do
      VCR.use_cassette('lastfm top tracks') do
        top_tracks = lastfm.send(:artist_top_tracks, 'Radiohead')
        top_tracks.should be_an(Array)
        top_tracks.should include('Nude')
      end
    end
  end
end
