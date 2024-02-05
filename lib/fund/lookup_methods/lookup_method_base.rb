# typed: strict
# frozen_string_literal: true

module NonViableMethod
  def viable?
    false
  end

  def self.viable?
    false
  end
end

module ViableMethod
  def viable?
    true
  end

  def self.viable?
    true
  end
end

class LookupMethodBase
  # XXX: this feels dumb, maybe follow https://stackoverflow.com/a/56800599
  #      I think I'm trying to treat this too much like traits in Scala
  extend NonViableMethod
  include NonViableMethod

  sig { params(url: T.nilable(String)).returns(T.nilable(LookupMethodBase)) }
  def self.try_from(url)
    raise NotImplementedError
  end
end
