desc "Reload CocoaPods Specs"
task :reload_cocoapods_specs => :environment do |t|
  PodLibrary.prepare
  sets = PodLibrary.sets
  specs = []
  sets.each do |set|
    begin
      specs << set.specification
    rescue => e
      puts "Skipping #{set.inspect} #{e}"
    end
  end
  # specs = specs.first(5) # For testing

  specs.each do |spec|
    puts "Checking #{spec.name}"
    pod = PodLibrary.where(name: spec.name).first_or_initialize
    [:summary, :description, :homepage, :social_media_url, :documentation_url].each do |attr|
      pod.send("#{attr}=", spec.send(attr))
    end
    pod.current_version = spec.version.to_s
    if spec.github?
      pod.git_source = spec.git_repo
      pod.git_tag = spec.git_tag.to_s if spec.git_tag
    end

    authors = spec.authors.map { |name, email| Author.where(name: name, email: email).first_or_initialize }
    pod.authors = authors

    pod.save!
  end
end

desc "Update repository stats"
task :update_repository_stats => :environment do |t|
  PodLibrary.find_each do |pod|
    puts "Checking #{pod.name}"
    success = pod.update_github_repo_data(save: true, fetch_repo_stats: true)
    puts "Failed #{pod.name}" unless success
  end
end

desc "Update commit activities"
task :update_commit_activities => :environment do |t|
  PodLibrary.find_each do |pod|
    puts "Checking #{pod.name}"
    success = pod.update_github_repo_data(save: true, fetch_commit_activities: true)
    puts "Failed #{pod.name}" unless success
  end
end

desc "Update commit contributors"
task :update_commit_contributors => :environment do |t|
  PodLibrary.find_each do |pod|
    puts "Checking #{pod.name}"
    success = pod.update_github_repo_data(save: true, fetch_contributors: true)
    puts "Failed #{pod.name}" unless success
  end
end

desc "Round-robin update GitHub data"
task :update_github_data => :environment do |t|
  PodLibrary.fetch_all_github_data(limit: 50)
end

desc "Update GitHub data of top 20 popular pods"
task :update_github_data_top_20 => :environment do |t|
  PodLibrary.fetch_all_github_data(limit: 20, order: { score: :desc })
end
