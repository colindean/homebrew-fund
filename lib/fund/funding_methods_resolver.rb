# typed: true
# frozen_string_literal: true

module FundingMethodsResolver
  sig { params(name: String).returns(String) }
  def self.suggest(name)
    odebug "Looking up formula for #{name}"
    formula = FormulaLoader.get_formula(name)
    return if formula.nil?

    odebug "Got #{formula}, resolving possible methods of resolving funding methods"

    methods = FormulaLookupMethodsResolver.instance.resolve(formula)
    by_viability = group_by_viability(methods)
    if by_viability.key? false
      nopes = by_viability[false]
      odebug "#{nopes.size} funding lookup methods non-viable for #{formula}: #{nopes.keys}"
    end
    failure_message = <<~EOS
      Try looking at its homepage, open it with 'brew homepage #{formula}' or look at 'brew info #{formula}' for other information.
    EOS
    unless by_viability.key? true
      onoe "No viable funding lookup methods available for #{formula}"
      return failure_message
    end
    ohai "#{by_viability[true].size} potential funding lookup method(s) for #{formula}"

    messages = by_viability[true].map do |source, method|
      ohai "Checking funding methods for #{source}"
      method.execute
    end.flatten

    if messages.empty? || messages.nil?
      failure_message
    else
      messages.to_s
    end
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
