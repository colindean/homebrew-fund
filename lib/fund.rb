# typed: strict
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require "fund/formula_loader"
require "fund/funding_methods_resolver"

require "fund/lookup_methods/lookup_method_base"
require "fund/lookup_methods_resolver"
require "fund/lookup_methods/github_sponsors_lookup"
require "fund/lookup_methods/no_lookup_available"
