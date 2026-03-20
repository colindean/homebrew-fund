# frozen_string_literal: true

class CoreTap
  def self.instance
    Tap.fetch
  end
end
