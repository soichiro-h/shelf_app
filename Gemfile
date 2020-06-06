# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.6'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '3.12.6'
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap-sass', '~> 3.4.1'
gem 'sass-rails', '~> 5.0.6'
gem 'uglifier', '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'

gem 'carrierwave'
gem 'devise'
gem 'dotenv-rails'
gem 'fog-aws'
gem 'gon'
gem 'google-api-client', '0.9.20', require: 'google/apis/youtube_v3'
gem 'mini_magick'
gem 'rack-user_agent'
gem 'rakuten_web_service'
gem 'trollop'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
