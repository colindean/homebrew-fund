# frozen_string_literal: true

require "spec_helper"

describe NoLookupAvailable do
  let(:test_url) { "https://github.com/homebrew/homebrew-fund" }

  describe "#try_form" do
    it "succeeds on any URL" do
      expected = described_class.new(test_url)
      expect(described_class.try_from(test_url)) == expected
    end

    it "is nonviable" do
      expect(described_class.new(test_url).viable?).to be(false)
      expect(described_class.viable?).to be(false)
    end
  end
end
