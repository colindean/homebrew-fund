# frozen_string_literal: true

source "https://rubygems.org"

group :test do
  # testing
  gem "rspec"
  gem "simplecov", require: false
  gem "simplecov-cobertura", require: false
  ## things that are already available in Homebrew processes
  gem "activesupport"
  # typechecking
  gem "rspec-sorbet"
  gem "sorbet-static-and-runtime"
  gem "tapioca", require: false, group: [:development, :test]
end
