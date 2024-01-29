# frozen_string_literal: true

class GitHubFundinglinksPresenter
  attr_reader :data

  # TODO: Maybe the hash should be its own type
  FundinglinksData = T.type_alias { T::Array[T::Hash[String, String]] } # rubocop:disable Style/MutableConstant

  def initialize(fundinglinks_data)
    @data = fundinglinks_data
  end

  def to_s
    return "GitHub Sponsors has no suggestions." if data.empty?

    entries = @data.map do |entry|
      "#{entry["platform"]} => #{entry["url"]}"
    end.join("\n")

    "GitHub Sponsors suggests:\n#{entries}"
  end
end
