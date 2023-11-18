# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  extend T::Sig

  sig { params(name: String).returns(String)}
  def self.suggest(name)
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    methods = LookupMethodsResolver.resolve(formula)

    methods.to_s
  end


end
