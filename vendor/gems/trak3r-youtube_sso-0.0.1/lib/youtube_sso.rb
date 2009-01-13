require 'net/http'
require 'uri'
require 'rubygems'
require 'hpricot'

class YouTubeSSO
  class << self
    def valid?(username, password)
      target = 'sso'
      response = Net::HTTP.post_form(URI.parse('http://www.youtube.com/login'),
        {
          'username' => username,
          'password' => password,
          'current_form' => 'loginForm',
          'next' => "/#{target}",
          'action_login' => 'Log+In'
        })
      page = Hpricot(response.body)
      denial = page.search("div[@class='errorBox']")
      if denial.empty?
        if "http://www.youtube.com/#{target}" == response['location']
          return true
        else
          return response # for debugging
        end
      else
        return false
      end
    end
  end
end
