# frozen_string_literal: true

require "spec_helper"

describe FundingMethodsResolver do
  subject(:working_resolver) { described_class.new("brew") }

  let(:test_resolver) { described_class.new("doesntmatter") }
  # let(:nla) { instance_double(NoLookupAvailable, url: "doesntmatter") }
  # let(:ghsl) { instance_double(GitHubSponsorsLookup, userorg: "lol", repo: "wut") }

  let(:nla) { NoLookupAvailable.new("doesntmatter") }
  let(:ghsl) { GitHubSponsorsLookup.new("lol", "wut") }

  describe "#group_by_viability" do
    it "splits out NoLookupAvailable" do
      exhibit = { homepage: nla, stable_url: ghsl }
      expected = { false => { homepage: nla }, true => { stable_url: ghsl } }

      expect(test_resolver.group_by_viability(exhibit)).to eq(expected)
    end
  end

  describe "#suggest_from_static_lookup" do
    it "finds for a known entry" do
      brew_fake_data = { repository: { fundingLinks: [
        { platform: "testplatform", url: "testurl" },
      ] } }.with_indifferent_access
      allow(GitHub::API).to receive(:open_graphql).and_return(brew_fake_data)
      actual = working_resolver.suggest_from_static_lookup

      expect(actual).not_to be_nil
      expect(actual).to include("testplatform")
    end

    it "doesn't find for a nonsense entry" do
      expect(test_resolver.suggest_from_static_lookup).to be_nil
    end
  end
end
