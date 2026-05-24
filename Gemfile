source 'https://rubygems.org'

gem 'rails', '~> 8.1.3'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'bootsnap', require: false

# Paginate
gem 'kaminari'

# Utils
gem 'ostruct'
gem 'freezolite'
gem 'alba'

group :development, :test do
  gem 'awesome_print'

  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false

  gem 'rubocop-rails-omakase', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]
