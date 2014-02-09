cont = PodLibrary.where(name: 'SCKit').first.id
PodLibrary.where("id > ?", cont).find_each(batch_size: 20) do |pod|
  puts "Checking #{pod.name}"
  success = pod.fetch_github_repo_data(update_repo: false, update_commits: false, update_contributors: false, update_releases: true)
  puts "Failed #{pod.name}" unless success
  # sleep 0.5
end
