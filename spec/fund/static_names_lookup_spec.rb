# frozen_string_literal: true

require "spec_helper"

describe StaticNamesLookup do
  let(:essentials) { ["brew", "homebrew-fund"] }

  describe "#try_form" do
    it "succeeds on two essential cases" do
      essentials.each do |e|
        expected = described_class.new(e)
        expect(described_class.try_from(e)).to eq(expected)
      end
    end

    it "fails successfully when the thing isn't in it" do
      expect(described_class.try_from("ljkahsdljkfhaklsdfhaklsdhf")).to be_nil
      expect(described_class.try_from(nil)).to be_nil
    end
  end

  describe "#viable?" do
    it "is viable" do
      expect(described_class.new(essentials.sample).viable?).to be(true)
      expect(described_class.viable?).to be(true)
    end
  end
end
