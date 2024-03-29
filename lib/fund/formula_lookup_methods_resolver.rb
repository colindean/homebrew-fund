# typed: true
# frozen_string_literal: true

require "uri"

require "singleton"

class FormulaLookupMethodsResolver
  include Singleton

  def initialize
    @lookup_methods = []
  end

  def installed_lookup_methods
    @lookup_methods
  end

  def install_lookup_method(cls)
    @lookup_methods << cls
  end

  sig { params(formula: Formula).returns(T::Hash[String, LookupMethodBase]) }
  def resolve(formula)
    data = FormulaLoader.collect_data(formula)

    data.transform_values do |url|
      installed_lookup_methods.lazy.map { |method| method.try_from(url) }.find { |v| !v.nil? }
    end
  end
end
