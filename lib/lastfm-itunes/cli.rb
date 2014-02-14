require 'yaml'
require 'highline/import'
require 'ruby-progressbar'

module LastfmItunes
  class CLI
    attr_reader :itunes_xml_path, :m3u_path, :limit
    attr_reader :lastfm_credentials, :username, :search_type

    def ask_itunes
      @itunes_xml_path = ask("Where is your iTunes Library XML file?  ") do |q|
        q.default = File.expand_path("~/Music/iTunes/iTunes Music Library.xml")
      end
    end

    def ask_m3u_path(options={})
      m3u_path = ask("Where to store generated playlist?  ") do |q|
        q.default = options.fetch(:m3u_path, m3u_default_path.to_s)
      end

      if File.exists?(m3u_path)
        answer = ask_overwrite_m3u
        if answer == 'No'
          m3u_path = ask_m3u_path(m3u_path: with_time(m3u_path))
        end
      end

      @m3u_path = m3u_path
    end

    def get_lastfm_credentials
      puts "Find or create Lastfm API secret and key here: http://www.last.fm/api/accounts".color(:yellow)

      lastfm_yml_path = File.expand_path("~/.config/lastfm-itunes.yml")
      lastfm_credentials = if File.exists?(lastfm_yml_path)
                             YAML.load_file(lastfm_yml_path)
                           else
                             {}
                           end
      @lastfm_credentials = { api_key: ask_api_key(lastfm_credentials),
                              api_secret:    ask_api_secret(lastfm_credentials) }
    end

    def ask_api_key(credentials=nil)
      ask("What is your Lastfm API Key?  ") do |q|
        q.default = credentials['api_key'] if credentials
      end
    end

    def ask_api_secret(credentials=nil)
      ask("What is your Lastfm API Secret?  ") do |q|
        q.default = credentials['api_secret'] if credentials
      end
    end

    def choose_search_type
      @search_type = choose do |menu| 
        menu.index = :number
        menu.index_suffix = ") "

        menu.prompt = "Search Artist global top tracks or User top tracks?  "

        menu.choice "Artist"
        menu.choice "User"
      end
    end

    def ask_limit(question_text)
      limit = ask(question_text) do |q|
        q.default = 'all'
      end
      @limit = limit.to_i > 0 ? limit.to_i : nil
    end

    def ask_username
      @username = ask("Username?  ") do |q|
        q.validate = /\A\w+\Z/
      end
    end

    def ask_overwrite_m3u
      choose do |menu| 
        menu.index = :number
        menu.index_suffix = ") "

        menu.prompt = "Overwite existing playlist file?  "

        menu.choice "Yes"
        menu.choice "No"
      end
    end

    def progressbar(total)
      ProgressBar.create(
        starting_at: 1,
        total: total,
        format: "%a".color(:cyan) + "|".color(:magenta) + "%B".color(:green) + "|".color(:magenta) +  "%p%%".color(:cyan))
    end

    def m3u_default_path
      Pathname(@itunes_xml_path).dirname.join('Lastfm Top Tracks.m3u')
    end

    def with_time(filepath)
      time_str = Time.now.strftime("%Y-%m-%d_%H%M%S")
      filepath.gsub(/\.m3u\Z/, " #{time_str}.m3u")
    end
  end
end
