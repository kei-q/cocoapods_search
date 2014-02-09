class AddRecentCommitAgeToPodLibrary < ActiveRecord::Migration
  def change
    add_column :pod_libraries, :recent_commit_age, :float, default: 1.0
  end
end
