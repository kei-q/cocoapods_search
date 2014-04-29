json.array!(@pods) do |pod|
  json.extract! pod, :name, :homepage, :social_media_url, :documentation_url, :summary, :description, :current_version, :current_version_released_at, :github_watcher_count, :github_stargazer_count, :github_fork_count, :github_contributor_count, :last_committed_at, :popularity, :rank
  json.url pod_url(pod.name, format: :json)
end
