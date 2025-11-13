# frozen_string_literal: true

class GitHubFundinglinksPresenter
  attr_reader :data

  # TODO: Maybe the hash should be its own type
  FundinglinksData = T.type_alias { T::Array[T::Hash[String, String]] }

  def initialize(fundinglinks_data)
    @repo_name = fundinglinks_data.dig("repository", "nameWithOwner")
    @data = fundinglinks_data.dig("repository", "fundingLinks")
    @platform_urls = @data.to_h do |entry|
      [entry["platform"], entry["url"]]
    end
  end

  def to_s
    return "GitHub Sponsors has no suggestions." if data.empty?

    entries = @platform_urls.map do |platform, url|
      "#{platform} => #{url}"
    end.join("\n")

    "GitHub Sponsors for #{@repo_name} suggests:\n#{entries}"
  end
end
