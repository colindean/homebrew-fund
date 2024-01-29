# typed: true
# frozen_string_literal: true

# rubocop:disable Lint/SymbolConversion
LOOKUP_TABLE = { "brew":          GitHubSponsorsLookup.new("homebrew", ".github"),
                 "homebrew-fund": GitHubSponsorsLookup.new("colindean",
                                                           "homebrew-fund"),
                 "sqlite":        "https://sqlite.org/prosupport.html" }.freeze
# rubocop:enable Lint/SymbolConversion

class StaticNamesLookup < LookupMethodBase
  extend ViableMethod
  include ViableMethod

  attr_reader :name

  sig { params(name: T.nilable(String)).returns(T.nilable(StaticNamesLookup)) }
  def self.try_from(name)
    return if name.nil?
    return StaticNamesLookup.new(name) if [name, name.to_sym].any? { |n| LOOKUP_TABLE.key?(n) }

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
    thing = LOOKUP_TABLE.fetch(name, LOOKUP_TABLE.fetch(name.to_sym))
    if thing.respond_to?(:execute)
      thing.execute
    else
      thing.to_s
    end
  end
end
