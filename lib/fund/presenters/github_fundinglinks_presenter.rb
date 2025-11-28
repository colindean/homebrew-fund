# frozen_string_literal: true

module Fund
  module Presenters
    class GitHubFundinglinksPresenter < Fund::Presenters::PresenterBase
      # TODO: Maybe the hash should be its own type
      FundinglinksData = T.type_alias { T::Array[T::Hash[String, String]] }

      def initialize(response_data)
        super
        @repo_name = response_data.dig("repository", "nameWithOwner")
        @link_data = response_data.dig("repository", "fundingLinks")
        @platform_urls = @link_data.to_h do |entry|
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

      def to_h
        {
          source: "github_api_fundinglinks",
          data:   @data,
        }
      end
    end
  end
end
