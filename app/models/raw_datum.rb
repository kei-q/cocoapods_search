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

class RawDatum < ActiveRecord::Base
  belongs_to :pod_library
  serialize :github_raw_data, Hash
end
