# frozen_string_literal: true

source "https://rubygems.org"

group :development do
  ## things that are already available in Homebrew processes
  gem "activesupport"
  # debugging
  gem "pry"
end

group :test do
  # testing
  gem "rspec"
  gem "simplecov", require: false
  gem "simplecov-cobertura", require: false

  # typechecking
  gem "rspec-sorbet"
  gem "sorbet-static-and-runtime"
  gem "tapioca", require: false, group: [:development, :test]
end
