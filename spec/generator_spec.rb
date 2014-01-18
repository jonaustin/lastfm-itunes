require 'spec_helper'
require 'pathname'

describe LastfmItunes::Generator do
  let(:m3u_path) { Pathname.new(__FILE__).join('..', '..', 'tmp', 'lastfm-itunes.m3u') }

  before { File.delete(m3u_path) if File.exists?(m3u_path) }

  it "should generate m3u of top tracks" do
    VCR.use_cassette('lastfm top tracks for all itunes artists') do
      generator = LastfmItunes::Generator.new(itunes_xml_path, lastfm_credentials, m3u_path: m3u_path)
      generator.generate_m3u
      generator.m3u.playlist_items.count.should == 82
      File.exists?(m3u_path).should be_true
    end
  end

  context 'm3u_path' do
    it 'should use default itunes path if none given' do
      generator = LastfmItunes::Generator.new(itunes_xml_path, lastfm_credentials)
      generator.m3u_path.should match /#{Pathname(itunes_xml_path).dirname}/
    end

    it 'should use options path if given' do
      generator = LastfmItunes::Generator.new(itunes_xml_path, lastfm_credentials, m3u_path: '/tmp/playlist.m3u')
      generator.m3u_path.should == '/tmp/playlist.m3u'
    end
  end
end
