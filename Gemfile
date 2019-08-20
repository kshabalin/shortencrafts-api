source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'rails', '~> 5.2.3'
gem 'puma', '~> 3.11'
gem 'bcrypt', '~> 3.1.7'
gem 'knock'
gem 'jwt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'iplocate'
gem 'fast_jsonapi'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
