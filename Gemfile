source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "rails", "~> 5.2.0"
gem "puma", "~> 3.11"
gem "cancancan"
gem "chartkick"
gem "mail"
gem "groupdate"
gem "config"
gem "devise"
gem "figaro"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-google-oauth2"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"
gem "bcrypt", "~> 3.1.7"
gem "carrierwave"           
gem "mini_magick"
gem "i18n"
gem "kaminari"
gem "bootstrap4-kaminari-views"
gem "bootstrap", "~> 4.1.1"
gem "font-awesome-rails"
gem "jquery-rails"
gem "bootsnap", ">= 1.1.0", require: false
gem "whenever", :require => false
gem "sidekiq"
gem "social-share-button"
gem "faker", :git => "https://github.com/stympy/faker.git", :branch => "master"

group :development, :test do
  gem "mysql2", ">= 0.4.4", "< 0.6.0"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
