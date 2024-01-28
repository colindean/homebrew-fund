# typed: true
# frozen_string_literal: true

require "active_support/core_ext/hash/indifferent_access"

LOOKUP_TABLE = { brew:            GitHubSponsorsLookup.new("homebrew", ".github"),
                 "homebrew-fund": GitHubSponsorsLookup.new("colindean",
                                                           "homebrew-fund") }.with_indifferent_access.freeze

class StaticNamesLookup < LookupMethodBase
  extend ViableMethod
  include ViableMethod

  attr_reader :name

  sig { params(name: T.nilable(String)).returns(T.nilable(StaticNamesLookup)) }
  def self.try_from(name)
    return StaticNamesLookup.new(name) if LOOKUP_TABLE.key?(name)

    nil
  end

  def initialize(name)
    super()
    @name = name
  end

  def ==(other)
    return false if other.class != self.class

    name == other.name
  end

  def hash
    name.hash
  end

  def execute
    thing = LOOKUP_TABLE.fetch(name)
    if thing.respond_to?(:execute)
      thing.execute
    else
      thing.to_s
    end
  end
end
