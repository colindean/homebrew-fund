# frozen_string_literal: true

require "spec_helper"

describe FundingMethodsResolver do
  subject(:resolver) { described_class.new("doesntmatter") }

  # let(:nla) { instance_double(NoLookupAvailable, url: "doesntmatter") }
  # let(:ghsl) { instance_double(GitHubSponsorsLookup, userorg: "lol", repo: "wut") }

  let(:nla) { NoLookupAvailable.new("doesntmatter") }
  let(:ghsl) { GitHubSponsorsLookup.new("lol", "wut") }

  describe "#group_by_viability" do
    it "splits out NoLookupAvailable" do
      exhibit = { homepage: nla, stable_url: ghsl }
      expected = { false => { homepage: nla }, true => { stable_url: ghsl } }

      expect(resolver.group_by_viability(exhibit)).to eq(expected)
    end
  end
end
