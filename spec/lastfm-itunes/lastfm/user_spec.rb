require 'spec_helper'

describe LastfmItunes::Lastfm::User do
  before { ::Rockstar.lastfm = lastfm_credentials }
  let(:user) { LastfmItunes::Lastfm::User.new(name: 'echowarpt') }
  let(:track) { OpenStruct.new(artist: 'Brian Eno', name: '2/1') }
  let(:more_popular_track) { OpenStruct.new(artist: 'Brian Eno', name: '1/1') }

  context 'my_top_tracks' do
    it "should return matching tracks in lastfm's order" do
      VCR.use_cassette('lastfm user top tracks') do
        user.my_top_tracks([track, more_popular_track]).should == [more_popular_track, track]
      end
    end

    it 'should ignore differences in case' do
      VCR.use_cassette('lastfm user top tracks') do
        messed_case_track = OpenStruct.new(artist: 'Yo la tengO', name: 'eVerydAy')
        user.my_top_tracks([messed_case_track]).should == [messed_case_track]
      end
    end

    it 'should respect limit' do
      VCR.use_cassette('lastfm user top tracks') do
        user.limit = 1
        user.my_top_tracks([track, more_popular_track]).should == [more_popular_track]
      end
    end
  end

  context 'user_top_tracks' do
    it 'should find top tracks for user' do
      VCR.use_cassette('lastfm user top tracks') do
        expect(
          user.top_tracks.any? { |t| t.name == 'Nude' }
        ).to be_true
      end
    end
  end
end

