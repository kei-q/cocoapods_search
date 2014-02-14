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

require 'spec_helper'

describe RawDatum do
  pending "add some examples to (or delete) #{__FILE__}"
end
