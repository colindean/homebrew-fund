# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  sig { params(name: String).returns(String) }
  def self.suggest(name)
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    methods = LookupMethodsResolver.resolve(formula)

    methods.to_s
  end
end
