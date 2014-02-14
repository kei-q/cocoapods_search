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
      pod.git_tag = spec.git_tag
    end
    pod.save!
  end
end