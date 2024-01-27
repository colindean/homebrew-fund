# frozen_string_literal: true

class LookupMethodBase
  sig { params(url: T.nilable(String)).returns(T.nilable(LookupMethodBase)) }
  def self.try_from(url)
    raise NotImplementedError
  end
end
