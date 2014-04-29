# == Schema Information
#
# Table name: authorings
#
#  id         :integer          not null, primary key
#  pod_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authoring do
  end
end
