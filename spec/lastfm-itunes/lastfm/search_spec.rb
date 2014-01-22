require 'spec_helper'
require 'ostruct'

describe LastfmItunes::Lastfm::Search do
  let(:search) {
    described_class.new(credentials: lastfm_credentials, name: 'Radiohead')
  }
  let(:track) { OpenStruct.new(artist: 'Radiohead', name: 'Nude') }
  let(:more_popular_track) { OpenStruct.new(artist: 'Radiohead', name: 'Creep') }

  context 'my_top_tracks' do
    it "should return matching tracks in lastfm's order" do
      VCR.use_cassette('lastfm top tracks') do
        search.my_top_tracks([track, more_popular_track]) \
          .should == [more_popular_track, track]
      end
    end

    it 'should respect limit' do
      search_with_limit = described_class.new(credentials: lastfm_credentials, 
                                              search_class: LastfmItunes::Lastfm::User, 
                                              name: 'echowarpt',
                                              limit: 1)
      VCR.use_cassette('lastfm user top tracks') do
        search_with_limit.top_tracks.size.should == 1
        top_track = search_with_limit.top_tracks
        search_with_limit.my_top_tracks([track, top_track].flatten).size.should == 1
      end
    end
  end
end
