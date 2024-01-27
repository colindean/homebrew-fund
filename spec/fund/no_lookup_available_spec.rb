# frozen_string_literal: true

require "spec_helper"

describe NoLookupAvailable do
  describe "#try_form" do
    it "succeeds on any URL" do
      test_url = "https://github.com/homebrew/homebrew-fund"
      expected = described_class.new(test_url)
      expect(described_class.try_from("https://github.com/homebrew/homebrew-fund")) == expected
    end
  end
end
