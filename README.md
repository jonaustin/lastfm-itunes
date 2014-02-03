[![Code Climate](https://codeclimate.com/github/jonaustin/lastfm-itunes.png)](https://codeclimate.com/github/jonaustin/lastfm-itunes)

# Lastfm iTunes Playlist Creator

Easily create playlists of top Lastfm tracks from your iTunes library.

http://jonaustin.io/posts/lastfm-itunes

## Installation

    gem install lastfm-itunes

## Usage

    lastfm-itunes

Follow the prompts to generate a playlist:


    Lastfm iTunes Playlist Creator
    ==============================

    Where is your iTunes Library XML file?  |~/Music/iTunes/iTunes Music Library.xml|
    Where to store generated playlist?  |~/Music/iTunes/Lastfm Top Tracks.m3u|

    Find or create Lastfm API secret and key here: http://www.last.fm/api/accounts
    What is your Lastfm API Key?
    What is your Lastfm API Secret?

    1) Artist
    2) User
    Search Artist global top tracks or User top tracks?  2
    Username?  echowarpt
    Maximum number of tracks to fetch?  |all| 500

    Extracting from iTunes....
      Found 64 artists and 1543 tracks
    Retrieving from Last.fm...
      Found 309 iTunes tracks out of 500 Last.fm tracks

    Generating Playlist.....

    Success! Your playlist has been generated at: /Users/jon/Music/iTunes/Lastfm Top Tracks.m3u

## Notes: 

* Each artist in the library requires a separate API call to Lastfm to get the top tracks. As a result generation could several minutes or more if there are hundreds or thousands of artists to fetch.

* It does not support tracks stored in the cloud. Haven't looked into whether this
is possible or not. Feel free to send a pull request.

* For convenience, lastfm credentials may be stored in ~/.config/lastfm-itunes.yml
If that file exists, then it will auto-fill the Lastfm API key and secret.

      api_key: ""
      api_secret: ""

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests.
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

License
-------

Copyright (c) 2014 Jon Austin.

Released under the MIT license. See `LICENSE.txt` for details.
