require "formula"
require "tap"

module FormulaLoader
  def self.get_formula(name)
    return Formula[name]
  end
end
