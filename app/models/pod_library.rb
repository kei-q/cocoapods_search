class PodLibrary < ActiveRecord::Base
  def documentation_url
    super || "http://cocoadocs.org/docsets/#{name}/#{current_version}/"
  end

  def current_version_released_at
    super || rand(365).days.ago
  end

  def first_version_released_at
    super || rand(1000).days.ago
  end

  def github_watcher_count
    super || rand(10)
  end

  def github_stargazer_count
    super || rand(10)
  end

  def github_fork_count
    super || rand(10)
  end

  def github_contributor_count
    super || rand(10)
  end

  def first_committed_at
    super || rand(1000).days.ago
  end

  def last_committed_at
    super || rand(100).days.ago
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
