# typed: true
# frozen_string_literal: true

require "utils/output"

class FundingMethodsResolver
  include ::Utils::Output::Mixin
  attr_reader :name

  def initialize(name)
    @name = name
  end

  sig { returns(String) }
  def suggest_all
    passing = [:suggest_from_static_lookup, :suggest_from_formula].lazy.map do |suggester|
      method(suggester).call
    end

    passing.find { |e| !e.nil? }
  end

  sig { returns(T.nilable(String)) }
  def suggest_from_static_lookup
    odebug "Checking static list"
    possible_static = StaticNamesLookup.try_from(name)

    return possible_static.execute.to_s if possible_static

    nil
  end

  sig { returns(T.nilable(String)) }
  def suggest_from_formula
    odebug "Looking up formula for #{name}"

    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    odebug "Got #{formula}, resolving possible methods of resolving funding methods"

    methods = FormulaLookupMethodsResolver.instance.resolve(formula)

    # TODO: rename "viability" to something like "executable" or "further steps required"
    #       non-viable really just means "we've exhausted lookups"
    by_viability = group_by_viability(methods)

    handle_nonviables(by_viability, formula)

    failure_message = <<~EOS
      Try looking at its homepage, open it with 'brew homepage #{formula}' or look at 'brew info #{formula}' for other information.
    EOS
    unless by_viability.key? true
      onoe "No viable funding lookup methods available for #{formula}"
      return failure_message
    end
    odebug "#{by_viability[true].size} potential funding lookup method(s) for #{formula}"

    messages = by_viability[true].map do |source, method|
      odebug "Checking funding methods for #{source}"
      method.execute
      # TODO: uniq usage here is such a hack, let's combine the GH Sponsors output into a single presenter instance
    end.flatten.uniq

    if messages.empty? || messages.nil?
      failure_message
    else
      messages.join("\n")
    end
  end

  GroupedByViability = T.type_alias { T::Hash[T::Boolean, T::Hash[String, LookupMethodBase]] }

  sig {
    params(by_viability: GroupedByViability, formula: Formula).returns(NilClass)
  }
  def handle_nonviables(by_viability, formula)
    return unless by_viability.key? false

    nopes = by_viability[false]
    odebug "#{nopes.size} funding lookup methods non-viable for #{formula}: #{nopes.keys}"
  end

  sig {
    params(methods: T::Hash[String, LookupMethodBase]).returns(GroupedByViability)
  }
  def group_by_viability(methods)
    methods.to_a.group_by do |hsh|
      hsh[1].viable?
    end.transform_values(&:to_h)
  end
end
