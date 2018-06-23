source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "actionpack-action_caching"
gem "activerecord-import"
gem "activerecord-quiet_schema_version"
gem "delayed_job_active_record"
gem "mechanize"
gem "pg", "~> 0.18"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.4"
gem "webpacker", "~> 3.2.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.7.0"
end

group :development do
  gem "capistrano", "3.10.1"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano3-puma"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "onkcop", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", "~> 2.18"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

ruby "2.4.2"
