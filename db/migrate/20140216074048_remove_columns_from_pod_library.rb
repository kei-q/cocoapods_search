class RemoveColumnsFromPodLibrary < ActiveRecord::Migration
  def up
    remove_column :pod_libraries, :recent_commits
    remove_column :pod_libraries, :github_raw_data
  end

  def down
    add_column :pod_libraries, :recent_commits, :text
    add_column :pod_libraries, :github_raw_data, :text
  end
end
