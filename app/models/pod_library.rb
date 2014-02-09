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
#  github_watcher_count        :integer
#  github_stargazer_count      :integer
#  github_fork_count           :integer
#  github_contributor_count    :integer
#  first_committed_at          :datetime
#  last_committed_at           :datetime
#  recent_commits              :text
#  created_at                  :datetime
#  updated_at                  :datetime
#  github_raw_data             :text
#

class PodLibrary < ActiveRecord::Base
  serialize :github_raw_data, Hash

  scope :search, -> (q) do
    query = "%#{q}%"
    where("name ILIKE :query OR summary ILIKE :query OR description ILIKE :query", query: query)
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
    end

    self.github_raw_data[:contributors] = github_contributors if update_contributors
    if github_raw_data[:contributors]
      self.github_contributor_count = github_raw_data[:contributors].size
    end

    self.github_raw_data[:releases] = github_releases if update_releases
    if github_raw_data[:releases]
      release = github_raw_data[:releases].find { |release| release.attrs[:tag_name] == git_tag }
      self.current_version_released_at = release.attrs[:created_at] if release
    end

    calc_score

    save
  rescue Octokit::NotFound => e
    logger.warn "Error: #{self.name} #{e}"
    false
  end

  def documentation_url
    super || "http://cocoadocs.org/docsets/#{name}/#{current_version}/"
  end

  def current_version_released_at
    super
  end

  def first_version_released_at
    super
  end

  def github_watcher_count
    super
  end

  def github_stargazer_count
    super
  end

  def github_fork_count
    super
  end

  def github_contributor_count
    super
  end

  def first_committed_at
    super
  end

  def last_committed_at
    super
  end

  def calc_score
    self.score = github_watcher_count + github_stargazer_count + github_fork_count + github_contributor_count
    # TODO(luvtechno): Consider recent activities
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
  def self.github_client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

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
