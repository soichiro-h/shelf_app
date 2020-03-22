module ApplicationHelper

  #require 'rubygems'
  #gem 'google-api-client', '>0.7'
  #require 'google/apis/youtube_v3'
  #require 'trollop'

  API_KEY = 'AIzaSyBWNozwiqcneF6nclfj2vhTF5-oJoC-_6Q'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  
  def get_service
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = API_KEY
      return youtube
  end
  
  
  
end
