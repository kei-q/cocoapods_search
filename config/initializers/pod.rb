class Pod::Specification
  class << self
    def github_client
      @client ||= Octokit::Client.new(oauth_token: ENV['GITHUB_TOKEN'])
    end
  end

  def git_repo
    source[:git]
  end

  def git_tag
    source[:tag]
  end

  def github?
    git_repo && git_repo.start_with?('https://github.com')
  end

  def github_repo_name
    match_data = git_repo.match("https://github.com/(.+?)/(.+?).git")
    "#{match_data[1]}/#{match_data[2]}"
  end

  def github_repo
    @repo ||= self.class.github_client.repo(github_repo_name)
  end
end
