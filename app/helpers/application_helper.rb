module ApplicationHelper

  #require 'rubygems'
  #gem 'google-api-client', '>0.7'
  #require 'google/apis/youtube_v3'
  #require 'trollop'

  API_KEY = ENV['YOUTUBE_API_KEY']
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  
  def get_service
      youtube = Google::Apis::YoutubeV3::YouTubeService.new
      youtube.key = API_KEY
      return youtube
  end
  
  def redirect_back_or
    if !user_session[:forwarding_url].blank?
      redirect_to( user_session[:forwarding_url] )
      user_session.delete(:forwarding_url)
    end
  end

  def store_location
    user_session[:forwarding_url] = request.original_url if request.get?
  end
  
  
end
