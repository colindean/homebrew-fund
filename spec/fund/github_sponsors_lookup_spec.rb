# frozen_string_literal: true

require "spec_helper"

describe GitHubSponsorsLookup do
  subject(:lookup) { described_class }

  describe "#try_form" do
    it "extracts user and org from a valid github.com URL" do
      expected = described_class.new("homebrew", "homebrew-fund")
      expect(lookup.try_from("https://github.com/homebrew/homebrew-fund")).to eq(expected)
    end

    it "returns nil when the URL domain is not github.com" do
      expect(lookup.try_from("https://brew.sh/docs/homebrew-governance")).to be_nil
    end

    it "returns nil when the URL is nil" do
      expect(lookup.try_from(nil)).to be_nil
    end
  end
end
