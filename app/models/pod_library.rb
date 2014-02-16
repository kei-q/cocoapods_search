# == Schema Information
#
# Table name: pod_libraries
#
#  id                          :integer          not null, primary key
#  name                        :string(255)
#  homepage                    :string(255)
#  social_media_url            :string(255)
#  documentation_url           :string(255)
#  summary                     :string(255)
#  description                 :text
#  git_source                  :string(255)
#  git_tag                     :string(255)
#  current_version             :string(255)
#  current_version_released_at :datetime
#  first_version_released_at   :datetime
#  github_watcher_count        :integer          default(0), not null
#  github_stargazer_count      :integer          default(0), not null
#  github_fork_count           :integer          default(0), not null
#  github_contributor_count    :integer          default(0), not null
#  first_committed_at          :datetime
#  last_committed_at           :datetime
#  recent_commits              :text
#  created_at                  :datetime
#  updated_at                  :datetime
#  github_raw_data             :text
#  score                       :integer          default(0), not null
#  recent_commit_age           :float            default(1.0)
#

class PodLibrary < ActiveRecord::Base
  has_one :raw_datum
  delegate :github_raw_data, to: :raw_datum

  ORDER_TYPES = %w(popularity contributors stargazers last_commit).freeze
  scope :sort, ->(order_type) do
    case order_type
    when 'popularity'
      order(score: :desc)
    when 'contributors'
      where('github_contributor_count IS NOT NULL').order(github_contributor_count: :desc)
    when 'stargazers'
      where('github_stargazer_count IS NOT NULL').order(github_stargazer_count: :desc)
    when 'last_commit'
      where('last_committed_at IS NOT NULL').order(last_committed_at: :desc)
    end
  end

  scope :search, -> (q) do
    query = "%#{q}%"
    where("name ILIKE :query OR summary ILIKE :query OR description ILIKE :query", query: query)
  end

  def self.github_client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def github?
    git_source.present? && git_source.start_with?('https://github.com')
  end

  def github_repo_name
    match_data = git_source.match("https://github.com/(.+?)/(.+?).git")
    "#{match_data[1]}/#{match_data[2]}"
  end

  def github_repo
    @repo ||= self.class.github_client.repo(github_repo_name)
  end

  def github_commits
    @commits ||= self.class.github_client.commits(github_repo_name)
  end

  def github_contributors
    @contributors ||= self.class.github_client.contributors(github_repo_name)
  end

  def github_releases
    @releases ||= self.class.github_client.releases(github_repo_name)
  end

  def github_tags
    @tags ||= self.class.github_client.tags(github_repo_name)
  end

  def github_current_release_commit_sha
    return nil unless github_raw_data[:tags]
    tag = github_raw_data[:tags].find { |tag| tag.attrs[:name] == git_tag }
    tag ? tag.attrs[:commit].attrs[:sha] : nil
  end

  def github_current_release_commit
    @current_release_commit ||= self.class.github_client.commit(github_repo_name, github_current_release_commit_sha)
  end

  def fetch_github_repo_data(update_repo: false, update_commits: false, update_contributors: false, update_releases: false)
    return false unless github?

    self.github_raw_data[:repo] = github_repo if update_repo
    if github_raw_data[:repo]
      self.github_watcher_count = github_raw_data[:repo].attrs[:subscribers_count]
      self.github_stargazer_count = github_raw_data[:repo].attrs[:stargazers_count]
      self.github_fork_count = github_raw_data[:repo].attrs[:forks_count]
    end

    self.github_raw_data[:commits] = github_commits if update_commits
    if github_raw_data[:commits]
      self.last_committed_at = github_raw_data[:commits].first.attrs[:commit].attrs[:committer].attrs[:date]
      dates = github_raw_data[:commits].map { |commit| commit.attrs[:commit].attrs[:committer].attrs[:date] }
      self.recent_commit_age = dates.map { |date| Time.now - date.to_time }.sum.to_f / dates.size / 86400 / 365
    end

    self.github_raw_data[:contributors] = github_contributors if update_contributors
    if github_raw_data[:contributors]
      self.github_contributor_count = github_raw_data[:contributors].size
    end

    if update_releases
      self.github_raw_data[:tags] = github_tags
      self.github_raw_data[:current_release_commit] = github_current_release_commit
    end
    if github_raw_data[:current_release_commit]
      self.current_version_released_at = github_raw_data[:current_release_commit].attrs[:commit].attrs[:committer].attrs[:date]
    end

    calc_score

    # Clean up old data
    self[:github_raw_data] = nil
    self.github_raw_data[:releases] = nil

    raw_datum.save && save
  rescue Octokit::NotFound => e
    logger.warn "Error: #{self.name} #{e}"
    false
  end

  def spec_url
    "https://github.com/CocoaPods/Specs/blob/master/#{name}/#{current_version}/#{name}.podspec"
  end

  def documentation_url
    super || "http://cocoadocs.org/docsets/#{name}/#{current_version}/"
  end

  def github_watcher_count
    super || 0
  end

  def github_stargazer_count
    super || 0
  end

  def github_fork_count
    super || 0
  end

  def github_contributor_count
    super || 0
  end

  def last_commit_age
    (Time.now - (last_committed_at || 1.year.ago)) / 86400.0 / 365
  end

  def calc_score
    github_score = github_watcher_count + github_stargazer_count + github_fork_count + github_contributor_count * 10
    age_factor = Math.exp(-recent_commit_age)
    self.score = github_score * age_factor
  end

  def self.sets
    @sets ||= Pod::Source.new(path).pod_sets
  end

  def self.prepare(force: false)
    if force || empty?
      get
      unpack
    end
  end

  private
  def self.path
    './tmp/specs'
  end

  def self.empty?
    Dir['./tmp/specs/*'].empty?
  end

  def self.get
    `curl -L -o ./tmp/specs.tar.gz http://github.com/CocoaPods/Specs/tarball/master`
  end

  def self.unpack
    `rm -rf ./tmp/specs`
    `gunzip -f ./tmp/specs.tar.gz`
    `cd tmp; tar xvf specs.tar`
    `mv -f ./tmp/CocoaPods-Specs-* ./tmp/specs`
  end
end
