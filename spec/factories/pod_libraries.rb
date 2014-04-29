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
#  github_watcher_count        :integer          default(0), not null
#  github_stargazer_count      :integer          default(0), not null
#  github_fork_count           :integer          default(0), not null
#  github_contributor_count    :integer          default(0), not null
#  first_committed_at          :datetime
#  last_committed_at           :datetime
#  created_at                  :datetime
#  updated_at                  :datetime
#  score                       :integer          default(0), not null
#  recent_commit_age           :float            default(1.0)
#  github_data_fetched_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pod_library do
  end
end
