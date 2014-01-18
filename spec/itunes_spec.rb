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
    itunes.artist_tracks['Radiohead'].should eq(['Nude', 'Reckoner'])
  end
end

