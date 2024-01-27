# typed: false
# frozen_string_literal: true

require "formula"
require "tap"

module FormulaLoader
  def self.get_formula(name)
    Formula[name]
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
