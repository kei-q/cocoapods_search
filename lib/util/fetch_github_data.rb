PodLibrary.find_each(batch_size: 100) do |pod|
  puts "Checking #{pod.name}"
  success = pod.fetch_github_repo_data(update_repo: false, update_commits: true, update_contributors: true, update_releases: true)
  puts "Failed #{pod.name}" unless success
end
