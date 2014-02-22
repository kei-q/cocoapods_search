cont = 0  # PodLibrary.where(name: 'SCKit').first.id
PodLibrary.where("id > ?", cont).find_each(batch_size: 20) do |pod|
  puts "Checking #{pod.name}"
  success = pod.update_github_repo_data(update_repo: false, update_commits: false, update_contributors: false, update_releases: false)
  puts "Failed #{pod.name}" unless success
  # sleep 0.5
end
