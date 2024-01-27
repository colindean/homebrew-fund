# frozen_string_literal: true

require "spec_helper"

describe LookupMethodBase do
  subject(:lookup) { described_class }

  describe "#try_form" do
    it "raises a not implemented error because it's a base class" do
      expect { lookup.try_from("f") }.to raise_error(NotImplementedError)
    end
  end
end
