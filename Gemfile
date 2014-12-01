source "https://rubygems.org"

ruby "2.1.5"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", github: "rails/rails", tag: "v4.2.0"
gem "ruby-oci8", "~> 2.1.0"
gem "activerecord-oracle_enhanced-adapter", github: "rsim/oracle-enhanced", branch: "rails42"
gem "query_string_search", "~> 0.0.4"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0",          group: :doc
gem "responders", "~> 2.0"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "capistrano",  "~> 3.1"
  gem "capistrano-rails", "~> 1.1"
end

group :development, :test do
  gem "web-console", "~> 2.0"
  gem "rspec", "~> 3"
  gem "rspec-rails", "~> 3"
  gem "rubocop", require: false
  gem "brakeman", require: false
end
