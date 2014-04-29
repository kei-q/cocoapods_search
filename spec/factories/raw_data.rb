# == Schema Information
#
# Table name: raw_data
#
#  id              :integer          not null, primary key
#  pod_library_id  :integer
#  github_raw_data :text
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :raw_datum do
    github_raw_data "MyText"
  end
end
