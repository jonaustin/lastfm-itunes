require 'spec_helper'

describe LastfmItunes::Itunes do
  let(:itunes) { LastfmItunes::Itunes.new( itunes_xml_path ) }

  it 'should load itunes library xml' do
    itunes.library.size.should == 161
  end

  it 'should raise exception if library empty or invalid' do
    expect{
      LastfmItunes::Itunes.new('')
    }.to raise_error(LastfmItunes::InvalidLibraryException)
  end

  it 'should group tracks by artist' do
    itunes.artist_tracks['Radiohead'].map(&:name).should eq(['Nude', 'Reckoner'])
  end

  it 'should store itunes hash' do
    itunes_track = itunes.library.music.tracks.select{ |t| t.artist == 'Radiohead' && t.name == 'Nude' }.first
    itunes.artist_tracks['Radiohead'].first.should == itunes_track
  end
end

