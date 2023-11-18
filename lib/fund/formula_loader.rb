# typed: false
# frozen_string_literal: true

require "formula"
require "tap"

module FormulaLoader
  def self.get_formula(name)
    Formula[name]
  end
end
