# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  def self.suggest(name)
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    data = {
      homepage:   formula.homepage,
      stable_url: formula.stable&.url,
      head_url:   formula.head&.url,
    }
    pp formula.stable
    data
  end
end
