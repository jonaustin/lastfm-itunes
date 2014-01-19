[![Code Climate](https://codeclimate.com/github/jonaustin/lastfm-itunes.png)](https://codeclimate.com/github/jonaustin/lastfm-itunes)
[![Build Status](https://travis-ci.org/jonaustin/lastfm-itunes.png?branch=master)](https://travis-ci.org/jonaustin/lastfm-itunes)
[![Coverage Status](https://coveralls.io/repos/jonaustin/lastfm-itunes/badge.png)](https://coveralls.io/r/jonaustin/lastfm-itunes)

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

    Number of tracks to fetch per artist?  |all|

    Generating.....
    Time: 00:01:00|==================================================================|100%

    Hurrah! Your playlist has been generated at: /Users/jon/Music/iTunes/Lastfm Top Tracks.m3u

## Notes: 

* Each artist in the library requires a separate API call to Lastfm to get the top tracks. As a result generation could take quite a while if there are many artists to fetch.

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
