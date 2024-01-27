# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  sig { params(name: String).returns(String) }
  def self.suggest(name)
    odebug "Looking up formula for #{name}"
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    odebug "Got #{formula}, resolving possible methods of resolving funding methods"

    methods = LookupMethodsResolver.resolve(formula)

    ohai "Potential funding methods for #{formula}"
    methods.to_s
  end
end
