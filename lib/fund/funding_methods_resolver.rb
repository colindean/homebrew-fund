# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  sig { params(name: String).returns(String) }
  def self.suggest(name)
    odebug "Looking up formula for #{name}"
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    odebug "Got #{formula}, resolving possible methods of resolving funding methods"

    methods = LookupMethodsResolver.instance.resolve(formula)

    viable = group_by_viability(methods)

    ohai "#{viable.size} potential funding method(s) for #{formula}"

    viable.to_s
  end

  sig {
    params(methods: T::Hash[String, LookupMethodBase]).returns(T::Hash[T::Boolean, T::Hash[String, LookupMethodBase]])
  }
  def self.group_by_viability(methods)
    methods.to_a.group_by do |hsh|
      hsh[1].viable?
    end.transform_values(&:to_h)
  end
end
