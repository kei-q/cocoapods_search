class Pod::Specification
  def git_repo
    source[:git]
  end

  def git_tag
    source[:tag]
  end

  def github?
    git_repo && git_repo.start_with?('https://github.com')
  end
end
