# typed: true
# frozen_string_literal: true

require "uri"

module LookupMethodsResolver
  def self.installed_lookup_methods
    [GitHubSponsorsLookup, NoLookupAvailable].freeze
  end

  sig { params(formula: Formula).returns(T::Hash[String, LookupMethodBase]) }
  def self.resolve(formula)
    data = collect_data(formula)

    data.transform_values do |url|
      installed_lookup_methods.find do |method|
        method.try_from(url) # &.execute_query
      end
    end
  end

  sig { params(formula: Formula).returns(T::Hash[Symbol, String]) }
  def self.collect_data(formula)
    {
      homepage:   formula.homepage,
      stable_url: formula.stable&.url,
      head_url:   formula.head&.url,
    }
  end
end
