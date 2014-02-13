class RawDatum < ActiveRecord::Base
  belongs_to :pod_library
  serialize :github_raw_data, Hash
end
