require 'spec_helper'

describe LastfmItunes::Itunes do
  let(:itunes) { LastfmItunes::Itunes.new( itunes_xml_path ) }

  it 'should load itunes library xml' do
    itunes.library.size.should == 162
  end

  it 'should raise exception if library empty or invalid' do
    expect{
      LastfmItunes::Itunes.new(__FILE__)
    }.to raise_error(LastfmItunes::InvalidLibraryException)
  end

  it 'should group tracks by artist' do
    expect(
      itunes.group_tracks_by_artist['Radiohead'].map(&:name)
    ).to eq(['Nude', 'Reckoner'])
  end

  it 'should store itunes hash' do
    itunes_track = itunes.tracks.select{ |t| t.artist == 'Radiohead' && t.name == 'Nude' }.first
    itunes.group_tracks_by_artist['Radiohead'].first.should == itunes_track
  end

  it 'should ignore tracks without a location_path (cloud)' do
    remote_itunes = LastfmItunes::Itunes.new( itunes_remote_xml_path )
    remote_itunes.tracks.size.should == 1
    remote_itunes.tracks.first.location_path.should_not be_nil
  end
end

