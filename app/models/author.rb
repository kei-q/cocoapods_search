# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  has_many :authorings
  has_many :pods, through: :authorings, source: :pod

  def to_param
    name.to_param
  end
end
