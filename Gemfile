source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.7'

gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby # C Ruby (MRI) or Rubinius, but NOT Windows

gem 'jquery-rails'
gem 'pjax_rails'
gem 'underscore-rails'

gem 'devise', '~> 4.8.0'
gem 'haml'
gem 'htmlentities'
gem 'rack-ssl', require: 'rack/ssl' # force SSL
gem 'rack-utf8_sanitizer', require: 'rack/utf8_sanitizer'

gem "paranoia", "~> 2.0"
gem 'useragent'
gem 'decent_exposure'
gem 'mail'
gem 'actionmailer_inline_css'
gem 'kaminari', '>= 0.14.1'
gem 'rack-ssl-enforcer', require: false
gem 'fabrication'
gem 'rails_autolink'
gem 'redcarpet', '~> 3.3.4'
gem 'gemoji', '~> 2.1.0'
gem 'progressbar', '~> 0.21.0', require: false
# Please don't update hoptoad_notifier to airbrake.
# It's for internal use only, and we monkeypatch certain methods
gem 'hoptoad_notifier', "~> 2.4"

gem 'activemodel-serializers-xml'

# Need for mongodb data import
gem 'mongo', require: false
gem 'bson_ext', ">= 1.12.5", require: false

# Remove / comment out any of the gems below if you want to disable
# a given issue tracker, notification service, or authentication.

# Issue Trackers
# ---------------------------------------
# Used by Mingle and Unfuddle
gem 'activeresource' #, '~> 4.0.0'
# Pivotal Tracker
gem 'pivotal-tracker', '~> 0.5.13'
# Fogbugz
gem 'ruby-fogbugz', '~> 0.1.1', require: 'fogbugz'
# Github Issues
gem 'octokit'
# Gitlab
gem 'gitlab', '~> 3.0.0'
# Bitbucket Issues
gem 'bitbucket_rest_api', '~> 0.1.7', require: false
# Jira
gem 'jira-ruby', '~> 0.1.2', require: 'jira'

# Notification services
# ---------------------------------------
gem 'campy', '~> 1.0.0'
# Hipchat
gem 'hipchat', '~> 0.12.0'
# Google Talk
gem 'xmpp4r', '~> 0.5.5', require: ["xmpp4r", "xmpp4r/muc"]
# Hoiio (SMS)
gem 'hoi'
# Pushover (iOS Push notifications)
gem 'rushover', '~> 0.3.0'
# Hubot
gem 'httparty'
# Flowdock
gem 'flowdock', '~> 0.3.1'

# Authentication
# ---------------------------------------
# GitHub OAuth
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

gem 'ri_cal'
gem 'oj'
gem 'multi_json'

# Required as long as we're using rspec <= 3.4
gem 'rake', '~> 11.2'

group :development, :test do
  gem 'rspec-rails', '~> 3.1'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'webmock', require: false
  gem 'airbrake', '~> 3.1.14', require: false
  gem 'pry-rails'
#  gem 'rpm_contrib'
#  gem 'newrelic_rpm'
  gem 'rails-controller-testing'
end

group :development do
  gem 'capistrano', '~> 2.0', require: false

  # better errors
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'foreman', require: false

  # Use puma for development
  gem 'puma', require: false
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'email_spec', '~> 1.5.0'
  gem 'timecop'
  gem 'coveralls', require: false
end

group :heroku, :production do
  gem 'unicorn', require: false
end
