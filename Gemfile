source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.2.5.2"
gem "ruby-oci8", "~> 2.2.1"
gem "activerecord-oracle_enhanced-adapter", "~> 1.6.0"
gem "query_string_search", "~> 0.0.7"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.3.1"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0",          group: :doc
gem "responders", "~> 2.0"

group :development do
  gem "spring", "~> 1.3.6"
  gem "spring-commands-rspec"
  gem "capistrano",  "~> 3.4.0"
  gem "capistrano-rails", "~> 1.1.3"
  gem "capistrano-passenger", "~> 0.1.1"
end

group :development, :test do
  gem "rspec", "~> 3.3.0"
  gem "rspec-rails", "~> 3.3.0"
  gem "rubocop", "~> 0.32", require: false
  gem "brakeman", "~> 3", require: false
end
