# typed: true
# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require "fund/formula_loader"
require "fund/funding_methods_resolver"

require "fund/lookup_methods/lookup_method_base"
require "fund/formula_lookup_methods_resolver"
require "fund/presenters/github_fundinglinks_presenter"
require "fund/lookup_methods/github_sponsors_lookup"
require "fund/lookup_methods/no_lookup_available"
require "fund/lookup_methods/static_names_lookup"
