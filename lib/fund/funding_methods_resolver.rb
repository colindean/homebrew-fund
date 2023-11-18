module FundingMethodsResolver
  def self.suggest(name)
    formula = FormulaLoader.get_formula(name)
    unless formula.nil?
      data = {
        homepage: formula.homepage,
        stable_url: (formula.stable ? formula.stable.url : nil),
        head_url: (formula.head ? formula.head.url : nil),
      }
      pp formula.stable
      data
    end
  end
end
