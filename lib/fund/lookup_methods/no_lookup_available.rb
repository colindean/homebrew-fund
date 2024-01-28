# typed: true
# frozen_string_literal: true

# This serves as a fallback/tail lookup method to clearly state that
# the formula doesn't have enough information to resolve a potential
# donation method.
class NoLookupAvailable < LookupMethodBase
  attr_reader :url

  sig { params(url: T.nilable(String)).returns(T.nilable(NoLookupAvailable)) }
  def self.try_from(url)
    NoLookupAvailable.new(url)
  end

  def initialize(url)
    super()
    @url = url
  end

  def to_s
    "no funding information lookup method available for #{@url}"
  end

  def ==(other)
    return false if other.class != self.class

    url == other.url
  end

  def hash
    url.hash
  end
end

FormulaLookupMethodsResolver.instance.install_lookup_method NoLookupAvailable
