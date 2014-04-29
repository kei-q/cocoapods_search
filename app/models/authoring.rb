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

class Authoring < ActiveRecord::Base
end
