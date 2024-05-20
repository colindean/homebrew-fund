# typed: false
# frozen_string_literal: true

def macos?
  RUBY_PLATFORM[/darwin/]
end

def linux?
  RUBY_PLATFORM[/linux/]
end

require "simplecov"
require "simplecov-cobertura"

SimpleCov.start do
  add_filter "/spec/stub/"
  add_filter "/vendor/"

  formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::CoberturaFormatter,
  ]
  formatter SimpleCov::Formatter::MultiFormatter.new(formatters)

  minimum_coverage 70

  command_name "Job #{ENV["TEST_ENV_NUMBER"]}" if ENV["TEST_ENV_NUMBER"]
end

# may be unnecessary for homebrew-fund, is present in brew spec_helper
if macos? && ENV["TEST_ENV_NUMBER"]
  SimpleCov.at_exit do
    result = SimpleCov.result
    result.format! if ParallelTests.number_of_running_processes <= 1
  end
end

require "bundler"
require "rspec/support/object_formatter"
require "rspec/sorbet"

Module.include(T::Sig)

PROJECT_ROOT = File.expand_path("..", __dir__).freeze
STUB_PATH = File.expand_path(File.join(__FILE__, "..", "stub")).freeze
$LOAD_PATH.unshift(STUB_PATH)

# require "os"
# require "global"
# require "fund"
require "utils"
require "github"

# require "active_support/core_ext/object/blank"
# require "active_support/core_ext/string/exclude"
# require "active_support/core_ext/enumerable"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/hash/indifferent_access"

requirables = Dir.glob("#{PROJECT_ROOT}/lib/**/*.rb").sort # rubocop:disable Lint/RedundantDirGlobSort

requirables.each do |file|
  next if file.include?("/extend/os/")

  require file
end

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.expect_with :rspec do |c|
    c.max_formatted_output_length = 200
  end

  # Never truncate output objects.
  RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = nil

  config.around do |example|
    Bundler.with_clean_env { example.run }
  end

  config.before(:each, :needs_linux) do
    skip "Not on Linux." unless linux?
  end

  config.before(:each, :needs_macos) do
    skip "Not on macOS." unless macos?
  end
end
