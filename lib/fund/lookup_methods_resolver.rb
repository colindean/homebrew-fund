# typed: true
# frozen_string_literal: true

require "uri"

module LookupMethodsResolver
  class LookupMethod
  end

  class GitHubSponsorsLookup < LookupMethod
    attr_reader :userorg, :repo

    GRAPHQL_QUERY = <<~QRY
        query ($name: String!, $owner: String!) {
        repository(owner: $owner, name: $name) {
          fundingLinks {
            platform
            url
          }
        }
      }
    QRY

    def initialize(userorg, repo)
      @userorg = userorg
      @repo = repo
    end

    def to_s
      "GitHub repo #{userorg}/#{repo}"
    end

    def ==(other)
      return false if other.class != self.class

      userorg == other.userorg && repo == other.repo
    end

    def hash
      [userorg, repo].hash
    end

    def execute_query
      GitHub::API.open_graphql(GRAPHQL_QUERY, variables: { owner: userorg, name: repo })
    end

    sig { params(url: T.nilable(String)).returns(T.nilable(GitHubSponsorsLookup)) }
    def self.try_from(url)
      return if url.nil?

      uri = URI(url)
      return if uri.host != "github.com"

      userorg_repo = extract_userorg_repo(uri.path)

      GitHubSponsorsLookup.new(userorg_repo[:userorg], userorg_repo[:repo])
    end

    sig { params(path: String).returns(T.nilable(T::Hash[Symbol, String])) }
    def self.extract_userorg_repo(path)
      userorg, repo = path.delete_prefix("/").split("/").take(2)
      { userorg: userorg, repo: repo.delete_suffix(".git") }
    end
  end

  sig { params(formula: Formula).returns(T::Hash[String, LookupMethod]) }
  def self.resolve(formula)
    data = collect_data(formula)

    data.transform_values { |url| GitHubSponsorsLookup.try_from(url)&.execute_query }
  end

  sig { params(formula: Formula).returns(T::Hash[Symbol, String]) }
  def self.collect_data(formula)
    {
      homepage:   formula.homepage,
      stable_url: formula.stable&.url,
      head_url:   formula.head&.url,
    }
  end
end
