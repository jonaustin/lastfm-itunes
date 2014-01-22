require 'spec_helper'
require 'pathname'

describe LastfmItunes::Generator do
  let(:m3u_path) { Pathname.new(__FILE__).join('..', '..', '..', 'tmp', 'lastfm-itunes.m3u') }
  let(:tracks) { ["/path/to/track.mp3", "/path/to/track2.mp3"] }

  before { File.delete(m3u_path) if File.exists?(m3u_path) }

  it "should generate m3u of top tracks" do
    VCR.use_cassette('lastfm top tracks for all itunes artists') do
      generator = LastfmItunes::Generator.new(m3u_path)
      generator.generate(tracks)
      generator.m3u.playlist_items.count.should == 2
      File.exists?(m3u_path).should be_true
    end
  end

  context 'm3u_path' do
    #it 'should use default m3u path if none given' do
      #default_args.delete(:m3u_path)
      #generator = LastfmItunes::Generator.new(default_args)
      #generator.m3u.path.should match /#{Pathname(itunes_xml_path).dirname}/
    #end

    it 'should use supplied m3u path' do
      generator = LastfmItunes::Generator.new('/tmp/playlist.m3u')
      generator.m3u.path.should == '/tmp/playlist.m3u'
    end
  end
end
