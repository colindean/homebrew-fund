# typed: true
# frozen_string_literal: true

require "uri"

# This retrieves the funding links available through the GitHub GraphQL API.
# https://docs.github.com/en/graphql/reference/objects#fundinglink
#
# This data should come from $org/$repo/.github/FUNDING.ya?ml
class GitHubSponsorsLookup < LookupMethodBase
  extend ViableMethod
  include ViableMethod

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
    super()
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

  def execute
    result = GitHub::API.open_graphql(GRAPHQL_QUERY, variables: { owner: userorg, name: repo })
    return if result.nil?

    result["repository"]["fundingLinks"]
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

FormulaLookupMethodsResolver.instance.install_lookup_method GitHubSponsorsLookup
