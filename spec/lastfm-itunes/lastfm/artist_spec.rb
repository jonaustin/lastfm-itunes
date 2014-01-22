require 'spec_helper'

describe LastfmItunes::Lastfm::Artist do
  before { ::Rockstar.lastfm = lastfm_credentials }
  let(:artist) { LastfmItunes::Lastfm::Artist.new(name: 'Radiohead') }
  let(:track) { OpenStruct.new(artist: 'Radiohead', name: 'Nude') }
  let(:more_popular_track) { OpenStruct.new(artist: 'Radiohead', name: 'Creep') }

  context 'my_top_tracks' do
    it "should return matching tracks in lastfm's order" do
      VCR.use_cassette('lastfm top tracks') do
        artist.my_top_tracks([track, more_popular_track]) \
          .should == [more_popular_track, track]
      end
    end

    it 'should ignore differences in case' do
      VCR.use_cassette('lastfm top tracks') do
        messed_case_track = OpenStruct.new(artist: 'Radiohead', name: 'cReeP')
        artist.my_top_tracks([messed_case_track]).should == [messed_case_track]
      end
    end

    it 'should respect limit' do
      VCR.use_cassette('lastfm top tracks') do
        artist.limit = 1
        artist.my_top_tracks([track, more_popular_track]).should == [more_popular_track]
      end
    end
  end

  context 'artist_top_tracks' do
    it 'should find top tracks for artist' do
      VCR.use_cassette('lastfm top tracks') do
        expect(
          artist.top_tracks.any? { |t| t.name == 'Nude' }
        ).to be_true
      end
    end
  end
end
